public class RazorpayRefundService {
    @AuraEnabled
    public static RazorpayRefundEntity createNormalRefund(String paymentId, Integer amount, String receipt, Map<String, String> notes){
        Map<String, Object> body = new Map<String, Object>{'amount' => amount, 'receipt' => receipt, 'notes' => notes, 'speed' => 'normal'};
        Map<String, String> replacer = new Map<String, String>{'{pay_id}' => paymentId};
        return (RazorpayRefundEntity) RazorpayPostRequestHelper.execute('RP_CREATE_NORMAL_REFUND', replacer, body);
    }

    @AuraEnabled
    public static RazorpayRefundEntity createInstantRefund(String paymentId, Integer amount, String receipt, Map<String, String> notes){
        Map<String, Object> body = new Map<String, Object>{'amount' => amount, 'receipt' => receipt, 'notes' => notes, 'speed' => 'optimum'};
        Map<String, String> replacer = new Map<String, String>{'{pay_id}' => paymentId};
        return (RazorpayRefundEntity) RazorpayPostRequestHelper.execute('RP_CREATE_INSTANT_REFUND', replacer, body);
    }

    @AuraEnabled
    public static RazorpayRefundEntity fetchAllRefunds(Integer count){
        return (RazorpayRefundEntity) RazorpayGetRequestHelper.execute('RP_FETCH_ALL_REFUNDS', 
                                                                          new Map<String, String>{'{count}' => String.valueOf(count)});
    } 

    @AuraEnabled
    public static RazorpayRefundEntity fetchRefundWithId(String refundId){
         return (RazorpayRefundEntity) RazorpayGetRequestHelper.execute('RP_FETCH_REFUND_WITH_ID', 
                                                                              new Map<String, String>{'{rfnd_id}' => refundId});
    }

    @AuraEnabled
    public static RazorpayRefundEntity fetchSpecificRefundForAPayment(String paymentId, String refundId){
         return (RazorpayRefundEntity) RazorpayGetRequestHelper.execute('RP_FETCH_SPECIFIC_REFUND_FOR_A_PAYMENT', 
                                                                              new Map<String, String>{'{rfnd_id}' => refundId,
                                                                                                      '{pay_id}' => paymentId});
    }

    @AuraEnabled
    public static RazorpayRefundEntity fetchMultipleRefundsForAPayment(String paymentId){
         return (RazorpayRefundEntity) RazorpayGetRequestHelper.execute('RP_FETCH_MULTIPLE_REFUND_FOR_A_PAYMENT', 
                                                                              new Map<String, String>{'{pay_id}' => paymentId});
    }
}