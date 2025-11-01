import { LightningElement, api, track } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import razorpayCheckout from '@salesforce/resourceUrl/RazorpayCheckoutScript'; // Assume this is the Static Resource name
import createOrder from '@salesforce/apex/RazorpayOrderService.createOrder';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class RazorpayCheckout extends LightningElement {
    // --- Public Properties (Passed from Parent) ---
    @api keyId;
    @api name;
    @api description;
    @api imageUrl;
    @api customerName;
    @api customerEmail;
    @api customerContact;

    @track isLoading = false;
    razorpayScriptLoaded = false;

    // --- Life Cycle Hooks: Load Script on initialization ---
    connectedCallback() {
        if (!this.razorpayScriptLoaded) {
            this.isLoading = true;
            loadScript(this, razorpayCheckout)
                .then(() => {
                    console.log('Razorpay Checkout script loaded successfully.');
                    this.razorpayScriptLoaded = true;
                })
                .catch(error => {
                    this.showToast('Error', 'Error loading Razorpay script. Check Static Resource.', 'error');
                })
                .finally(() => {
                    this.isLoading = false;
                });
        }
    }

    // --- Public Method: Callable from Parent Component ---
    /**
     * @api
     * Method to initiate the Razorpay checkout process.
     * @param {Object} paymentInfo Must contain { amount, currency, receiptId }.
     */
    @api
    async openRazorpay(paymentInfo) {
        if (!this.razorpayScriptLoaded) {
            this.showToast('Error', 'Payment script not ready. Try again in a moment.', 'error');
            return;
        }
        
        const { amount, currency, receipt } = paymentInfo;
        if (!amount || !currency ) {
            this.showToast('Error', 'Missing payment data (amount, currency).', 'error');
            return;
        }

        this.isLoading = true;
        
        try {
            // 1. Create Order on Razorpay Server via Apex
            let order = await createOrder({
                amount: amount,
                currencyValue: currency,
                receipt: receipt,
                notes: null
            });
            console.log('Order ' + JSON.stringify(order, null, 2)); 
            
            if (!order || !order.id) {
                throw new Error('Failed to create Razorpay Order.');
            }

            // 2. Prepare Checkout Options
            const options = {
                key: this.keyId,
                amount: order.amount,       // Amount from order response (in smallest unit)
                currency: order.currencyValue,   // Currency from order response
                name: this.name,
                description: this.description,
                order_id: order.id,         // Razorpay Order ID
                handler: (response) => {
                    // Success callback
                    this.handlePaymentSuccess(response);
                },
                prefill: {
                    name: this.customerName,
                    email: this.customerEmail,
                    contact: this.customerContact
                },
                modal: {
                    ondismiss: () => {
                        this.handlePaymentFailure('Payment window closed by user.');
                    }
                },
                theme: {
                    color: '#3399cc'
                }
            };

            // 3. Open Razorpay Checkout Modal
            const rzp = new Razorpay(options);
            rzp.on('payment.failed', (response) => {
                this.handlePaymentFailure(response.error.description || 'Payment Failed.');
            });

            rzp.open();

        } catch (error) {
            this.handlePaymentFailure(error.message || 'An unexpected error occurred during checkout initiation.');
        } finally {
            // The spinner should be managed inside the handler/failure logic if needed, 
            // but we can hide it here since the popup is open/failed.
            this.isLoading = false; 
        }
    }

    // --- Event Handlers (Fire custom events to Parent) ---
    handlePaymentSuccess(response) {
        this.showToast('Success', `Payment ID: ${response.razorpay_payment_id}.`, 'success');
        
        // Fire a custom event to parent to handle signature verification and record update
        this.dispatchEvent(new CustomEvent('paymentsuccess', {
            detail: {
                paymentId: response.razorpay_payment_id,
                orderId: response.razorpay_order_id,
                signature: response.razorpay_signature
            }
        }));
    }

    handlePaymentFailure(message) {
        this.showToast('Payment Failed', message, 'error');

        // Fire a custom event to parent to handle failure logic
        this.dispatchEvent(new CustomEvent('paymentfailure', {
            detail: { message }
        }));
    }

    // --- Helper ---
    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}