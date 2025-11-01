public class RazorpayPaymentCardEntity extends RazorpayBaseEntity{
    @AuraEnabled public boolean emi;
    @AuraEnabled public String entity;	    //card
    @AuraEnabled public String id;	    //card_DESp9fNnu0RoNc
    @AuraEnabled public String iin;	    //999999
    @AuraEnabled public boolean international;
    @AuraEnabled public String issuer;
    @AuraEnabled public String last4;	    //0153
    @AuraEnabled public String name;	    //<name>
    @AuraEnabled public String network;	    //Visa
    @AuraEnabled public String sub_type;	    //business
    @AuraEnabled public String type;	    //debit
}