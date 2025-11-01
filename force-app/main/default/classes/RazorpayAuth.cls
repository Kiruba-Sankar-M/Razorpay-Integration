public virtual class RazorpayAuth {
    public virtual String getNamedCredential(){
        System.debug(Payment_Gateway_Config__mdt.getInstance('Razorpay_Config').Named_Credential__c);
        return Payment_Gateway_Config__mdt.getInstance('Razorpay_Config').Named_Credential__c;
    }
}