public class RazorpayPaymentLinkEntity extends RazorpayBaseEntity{
    @AuraEnabled public boolean accept_partial;
	@AuraEnabled public Integer amount;	    //1000
	@AuraEnabled public Integer amount_paid;	    //1000
	@AuraEnabled public Integer cancelled_at;	    //0
	@AuraEnabled public Integer created_at;	    //1749618314
	@AuraEnabled public String currencyValue;	    //INR
	@AuraEnabled public customer customer;
	@AuraEnabled public String description;	    //Test Payment
	@AuraEnabled public Integer expire_by;	    //0
	@AuraEnabled public Integer expired_at;	    //0
	@AuraEnabled public Integer first_min_partial_amount;	    //0
	@AuraEnabled public String id;	    //plink_QflcnnZqCekuvL
	@AuraEnabled public Map<String,String> notes;
	@AuraEnabled public notify notify;
	@AuraEnabled public String order_id;	    //order_QflczVVaNJciLq
	@AuraEnabled public String reference_id;	    //23
	@AuraEnabled public boolean reminder_enable;
	@AuraEnabled public reminders reminders;
	@AuraEnabled public String short_url;	    //https://rzp.io/rzp/twH5w1Y
	@AuraEnabled public String status;	    //paid
	@AuraEnabled public Integer updated_at;	    //1749618371
	@AuraEnabled public boolean upi_link;
	@AuraEnabled public String user_id;	    //HWPf1AudnADDV5p
	@AuraEnabled public boolean whatsapp_link;
	
	class customer {
		@AuraEnabled public String contact;	    //9000090000
		@AuraEnabled public String email;	    //gauravkumar@example.com
	}

	class notify {
		@AuraEnabled public boolean email;
		@AuraEnabled public boolean sms;
		@AuraEnabled public boolean whatsapp;
	}

	class reminders {
		@AuraEnabled public String status;	    //failed
	}
}