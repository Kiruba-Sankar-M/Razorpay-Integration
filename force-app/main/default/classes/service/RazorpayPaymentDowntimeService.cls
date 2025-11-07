public class RazorpayPaymentDowntimeService {
   
     public RazorpayDowntimeEntity fetchPaymentDowntimeById(String id){
         return (RazorpayDowntimeEntity) RazorpayGetRequestHelper.execute('RP_FETCH_PAYMENT_DOWNTIME_DETAIL_BY_ID', new Map<String, String>{'{down_id}'=> id});
    }

    public RazorpayDowntimeEntity fetchAllPaymentDowntimeDetails(){
         return (RazorpayDowntimeEntity) RazorpayGetRequestHelper.execute('RP_FETCH_ALL_PAYMENT_DOWNTIME_DETAILS', NULL);
    }
}