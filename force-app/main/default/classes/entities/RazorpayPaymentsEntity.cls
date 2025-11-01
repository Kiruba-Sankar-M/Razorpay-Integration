public class RazorpayPaymentsEntity extends RazorpayBaseEntity{
    @AuraEnabled public String entity;	    //collection
	@AuraEnabled public Integer count;	    //2
	@AuraEnabled public List<RazorpayPaymentEntity> items;
}