public with sharing class RazorpayWebhookEntity extends RazorpayBaseEntity{
    public String account_id;	    //acc_MWWeS9Ico5tQBk
	public List<String> contains;
	public Integer created_at;	    //1748425227
	public String entity;	    //event
	public String event;	    //payment_link.partially_paid
	public payload payload;

    class payload {
		public order order;
		public payment payment;
		public payment_link payment_link;
	}
	
    class order {
		public RazorpayOrderEntity entity;
	}

    class payment {
		public RazorpayPaymentEntity entity;
	}

    class payment_link {
		public RazorpayPaymentLinkEntity entity;
	}
}