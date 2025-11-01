public class RazorpayDowntimeEntity extends RazorpayBaseEntity {
    @AuraEnabled public String id;	    //down_Ql8NrxCZohraK8
	@AuraEnabled public String entity;	    //payment.downtime
	@AuraEnabled public String method;	    //emandate
	@AuraEnabled public Integer beginValue;	    //1750790163
	@AuraEnabled public endValue endValue;
	@AuraEnabled public String status;	    //started
	@AuraEnabled public boolean scheduled;
	@AuraEnabled public String severity;	    //high
	@AuraEnabled public instrument instrument;
	@AuraEnabled public Integer created_at;	    //1750790163
	@AuraEnabled public Integer updated_at;	    //1750790163
	class endValue {
	}

	class instrument {
		@AuraEnabled public String bank;	    //PYTM
	}
}