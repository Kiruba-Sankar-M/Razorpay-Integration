public class RazorpayPaymentService {
    @AuraEnabled
    public static RazorpayPaymentEntity capturePayment(String paymentId, Integer amount, String currencyValue){
        Map<String, Object> body = new Map<String, Object>{'amount' => amount, 'currency' => currencyValue};
        Map<String, String> replacer = new Map<String, String>{'{pay_id}' => paymentId};
        return (RazorpayPaymentEntity) RazorpayPostRequestHelper.execute('RP_CAPTURE_PAYMENT', replacer, body);
    }

    @AuraEnabled
    public static RazorpayPaymentEntity fetchPaymentWithId(String paymentId){
        return (RazorpayPaymentEntity) RazorpayGetRequestHelper.execute('RP_FETCH_PAYMENT_WITH_ID', new Map<String, String>{'{pay_id}' => paymentId});
    }

    @AuraEnabled
    public static RazorpayPaymentEntity fetchPaymentWithCardDetails(String paymentId){
        return (RazorpayPaymentEntity) RazorpayGetRequestHelper.execute('RP_FETCH_PAYMENT_WITH_CARD_DETAILS', new Map<String, String>{'{pay_id}' => paymentId});
    } 
    
    @AuraEnabled
    public static RazorpayPaymentEntity fetchPaymentWithEmiDetails(String paymentId){
        return (RazorpayPaymentEntity) RazorpayGetRequestHelper.execute('RP_FETCH_PAYMENT_WITH_EMI_DETAILS', new Map<String, String>{'{pay_id}' => paymentId});
    } 
    
    @AuraEnabled
    public static RazorpayPaymentEntity fetchPaymentWithOfferDetails(String paymentId){
        return (RazorpayPaymentEntity) RazorpayGetRequestHelper.execute('RP_FETCH_PAYMENT_WITH_OFFER_DETAILS', new Map<String, String>{'{pay_id}' => paymentId});
    } 

    @AuraEnabled
    public static RazorpayPaymentsEntity fetchAllPayments(){
        return (RazorpayPaymentsEntity) RazorpayGetRequestHelper.execute('RP_FETCH_ALL_PAYMENTS', NULL);
    } 

    @AuraEnabled
    public static RazorpayPaymentsEntity fetchAllPaymentsWithCardDetails(Integer count){
        return (RazorpayPaymentsEntity) RazorpayGetRequestHelper.execute('RP_FETCH_ALL_PAYMENTS_WITH_CARD_DETAILS', new Map<String, String>{'{count}' => String.valueOf(count)});
    } 

    @AuraEnabled
    public static RazorpayPaymentsEntity fetchAllPaymentsWithEmiDetails(Integer count){
        return (RazorpayPaymentsEntity) RazorpayGetRequestHelper.execute('RP_FETCH_ALL_PAYMENTS_WITH_EMI_DETAILS',  new Map<String, String>{'{count}' => String.valueOf(count)});
    } 

    @AuraEnabled
    public static RazorpayPaymentsEntity fetchPaymentsForAnOrder(String orderId){
         return (RazorpayPaymentsEntity) RazorpayGetRequestHelper.execute('RP_FETCH_PAYMENT_BASED_ON_ORDER', new Map<String, String>{'{order_id}' => orderId});
    }

    @AuraEnabled
    public static RazorpayPaymentCardEntity fetchCardDetailsOfAPayment(String paymentId){
         return (RazorpayPaymentCardEntity) RazorpayGetRequestHelper.execute('RP_FETCH_CARD_DETAIL_OF_A_PAYMENT', new Map<String, String>{'{pay_id}' => paymentId});
    }
}