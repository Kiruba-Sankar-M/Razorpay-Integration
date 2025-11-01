public with sharing class RazorpayPostRequestHelper {
    public static RazorpayBaseEntity execute(String metadataDeveloperName, Map<String, String> replacer, Map<String, Object> body){
        Payment_Endpoint__mdt endpointDetails = Payment_Endpoint__mdt.getInstance(metadataDeveloperName);
        
        if(endpointDetails == NULL) throw new RazorpayException('No custom metadata record available in Payment_Endpoint__mdt with developer name as ' + metadataDeveloperName);
        
        RazorpayRequestBuilder request = new RazorpayRequestBuilder();
        
        String requestBody = RazorpayRequestBodyTransformHelper.transform(body);

        HttpResponse response = request.setEndpoint(endpointDetails.Endpoint_URL__c, replacer)
                                                                     .setMethod(endpointDetails.REST_Method__c)
                                                                     .setBody(requestBody)
                                                                     .send();

        if(request.validate(response, endpointDetails.Success_Response_Code__c)){
            return RazorpayResponseToEntityTransformHelper.transform(response, endpointDetails.Response_Entity_Apex_Class__c);
        }

        return null;
    }
}