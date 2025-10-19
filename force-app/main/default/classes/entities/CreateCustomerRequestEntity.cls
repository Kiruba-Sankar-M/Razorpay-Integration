public with sharing class CreateCustomerRequestEntity {
    public String name;	    
	public String email;	    
	public String contact;	    
	public String fail_existing; /*1 (default): If a customer with the same details already exists, throws an error.
                                   0: If a customer with the same details already exists, fetches details of the existing customer.*/
	public String gstin;	    
	public Map<String, String> notes;

	public CreateCustomerRequestEntity(){
		notes = new Map<String,String>();
	}
}