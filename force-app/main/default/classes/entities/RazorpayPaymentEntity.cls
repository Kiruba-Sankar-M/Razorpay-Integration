public class RazorpayPaymentEntity extends RazorpayBaseEntity{
    @AuraEnabled public String id;	    //pay_DESp9bgForNoUd
	@AuraEnabled public String entity;	    //payment
	@AuraEnabled public Integer amount;	    //100
	@AuraEnabled public String currencyValue;	    //INR
	@AuraEnabled public Integer base_amount;	    //100
	@AuraEnabled public String status;	    //captured
	@AuraEnabled public String order_id;	    //order_DESoU0U4ikYA19
	@AuraEnabled public String invoice_id;
	@AuraEnabled public boolean international;
	@AuraEnabled public String method;	    //card
	@AuraEnabled public Integer amount_refunded;	    //0
	@AuraEnabled public Integer amount_transferred;	    //0
	@AuraEnabled public String refund_status;
	@AuraEnabled public boolean captured;
	@AuraEnabled public String description;
	@AuraEnabled public String card_id;	    //card_DESp9fNnu0RoNc
	@AuraEnabled public String bank;
	@AuraEnabled public String wallet;	    //payzapp
	@AuraEnabled public String vpa;
	@AuraEnabled public String email;	    //<email>
	@AuraEnabled public String contact;	    //<phone>
	@AuraEnabled public Map<String,String> notes;
	@AuraEnabled public Integer fee;
	@AuraEnabled public Integer tax;
	@AuraEnabled public String error_code;	    //BAD_REQUEST_ERROR
	@AuraEnabled public String error_description;	    //Payment failed
	@AuraEnabled public String error_source;	    //bank
	@AuraEnabled public String error_step;	    //payment_authorization
	@AuraEnabled public String error_reason;	    //payment_failed
	@AuraEnabled public acquirer_data acquirer_data;
	@AuraEnabled public Integer created_at;	    //1567674797
	@AuraEnabled public upi upi;
	@AuraEnabled public RazorpayPaymentCardEntity card;
	@AuraEnabled public String token_id;	    //token_MOfFlFTC1CBDOi

	class acquirer_data {
		@AuraEnabled public String bank_transaction_id;	    //0125836177
		@AuraEnabled public String transaction_id;	    //
		@AuraEnabled public String auth_code;	    //828553
		@AuraEnabled public String rrn;	    //322206890934
	}

	class upi {
		@AuraEnabled public String payer_account_type;	    //credit_card
		@AuraEnabled public String vpa;	    //gaurav.kumar@upi
		@AuraEnabled public String flow;	    //intent
	}
}