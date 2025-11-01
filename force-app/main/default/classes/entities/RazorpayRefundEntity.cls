public class RazorpayRefundEntity extends RazorpayBaseEntity{
    @AuraEnabled public String id;	    //rfnd_FgRAHdNOM4ZVbO
	@AuraEnabled public String entity;	    //refund
	@AuraEnabled public Integer amount;	    //10000
	@AuraEnabled public String currencyValue;	    //<currency>
	@AuraEnabled public String payment_id;	    //pay_FgR9UMzgmKDJRi
	@AuraEnabled public Map<String,String> notes;
	@AuraEnabled public String receipt;	    //
	@AuraEnabled public acquirer_data acquirer_data;
	@AuraEnabled public Integer created_at;	    //1600856650
	@AuraEnabled public String batch_id;	    //
	@AuraEnabled public String status;	    //processed
	@AuraEnabled public String speed_processed;	    //normal
	@AuraEnabled public String speed_requested;	    //normal

	class acquirer_data {
		@AuraEnabled public String arn;	    //10000000000000
	}

}