public with sharing class CreateCustomerResponseEntity {
    public String id;	    //cust_1Aa00000000004
	public String entity;	    //customer
	public String name;	    //Gaurav Kumar
	public String email;	    //gaurav.kumar@example.com
	public String contact;	    //+919876543210
	public gstin gstin;
	public notes notes;
	public Integer created_at ;	    //1234567890
	public error error;
	class gstin {
	}

	class notes {
		public String notes_key_1;	    //Tea, Earl Grey, Hot
		public String notes_key_2;	    //Tea, Earl Grey… decaf.
	}

	class error {
		public String code;	    //BAD_REQUEST_ERROR
		public String description;	    //Contact number should be at least 8 digits, including country code
		public String source;	    //business
		public String step;	    //NA
		public String reason;	    //invalid_contact_number
		public metadata metadata;
		public String field;	    //contact
	}

	class metadata {
	}
}