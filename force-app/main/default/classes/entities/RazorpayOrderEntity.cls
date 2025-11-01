public class RazorpayOrderEntity extends RazorpayBaseEntity{
    @AuraEnabled public String id;	    //order_DESlLckIVRkHWj
	@AuraEnabled public String entity;	    //order
	@AuraEnabled public Integer amount;	    //100
	@AuraEnabled public Integer amount_paid;	    //100
	@AuraEnabled public Integer amount_due;	    //0
	@AuraEnabled public String currencyValue;	    //INR
	@AuraEnabled public String receipt;	    //rcptid #1
	@AuraEnabled public String offer_id;
	@AuraEnabled public String status;	    //paid
	@AuraEnabled public Integer attempts;	    //1
	@AuraEnabled public Map<String,String> notes;
	@AuraEnabled public Integer created_at;	    //1567674581
	@AuraEnabled public RazorpayPaymentsEntity payments;
}