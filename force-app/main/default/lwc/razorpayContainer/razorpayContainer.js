import { LightningElement } from 'lwc';

export default class RazorpayContainer extends LightningElement {
    customer = {
        name: 'John Doe',
        email: 'john.doe@example.com',
        contact: '9999999999'
    };

    paymentData = {
        amount: 500.00, // The amount you want to charge
        currency: 'INR',
        receiptId: 'ORD_' + Date.now() 
    };

    // --- Core Logic: Called when the button is clicked ---
    initiateCheckout() {
        // 1. Get a reference to the child component
        const razorpayComp = this.template.querySelector('c-razorpay-checkout');
        
        if (razorpayComp) {
            // 2. Call the public method on the child
            razorpayComp.openRazorpay(this.paymentData)
                .catch(error => {
                    console.error('Error calling openRazorpay:', error);
                });
        }
    }

    // --- Handlers for Custom Events from Child ---
    handlePaymentSuccess(event) {
        const { paymentId, orderId, signature } = event.detail;
        console.log(`Payment Successful. ID: ${paymentId}`);
        // TODO: Call Apex method for SIGNATURE VERIFICATION and update Salesforce record
        // e.g., this.verifyAndFinalizePayment(paymentId, orderId, signature);
    }

    handlePaymentFailure(event) {
        const { message } = event.detail;
        console.error(`Payment Failed: ${message}`);
        // TODO: Update Salesforce record to 'Failed' or show user a custom error.
    }
}