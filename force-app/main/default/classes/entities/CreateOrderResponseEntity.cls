public with sharing class CreateOrderResponseEntity {
    public Integer amount;	    //5000
	public Integer amount_due;	    //5000
	public Integer amount_paid;	    //0
	public Integer attempts;	    //0
	public Integer created_at;	    //1756455561
	public String currencyValue;	    //INR
	public String entity;	    //order
	public String id;	    //order_RB58MiP5SPFYyM
	public offer_id offer_id;
	public String receipt;	    //receipt#1
	public String status;	    //created
	public error error;
	public Map<String,String> notes;

	class offer_id {
	}

	class error {
		public String code;	    //BAD_REQUEST_ERROR
		public String description;	    //The amount must be atleast INR 1.00
		public String source;	    //business
		public String step;	    //payment_initiation
		public String reason;	    //input_validation_failed
		public metadata metadata;
		public String field;	    //amount
	}

	class metadata {
	}
}