@RestResource(urlMapping='/razorpay/webhook')
global with sharing class RazorpayWebhookApi {
    
    @HttpPost
    global static void handleWebhook() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        
        try {

            String body = RazorpayResponseBodyTransformHelper.transform(req.requestBody.toString());
            if (String.isBlank(body)) {
                res.statusCode = 400;
                res.responseBody = Blob.valueOf('{"error": "Empty request body"}');
                return;
            }

            // Deserialize incoming webhook JSON
            RazorpayWebhookEntity event = (RazorpayWebhookEntity) JSON.deserialize(body, RazorpayWebhookEntity.class);
            System.debug('Webhook Event :'+ event);
            if (event == null || String.isBlank(event.event)) {
                res.statusCode = 400;
                res.responseBody = Blob.valueOf('{"error": "Invalid or missing event"}');
                return;
            }

            // Get metadata configuration for the event
            Payment_Webhook_Event__mdt eventConfig = [SELECT Id, Logic_Implementer_Apex_Class__c 
                                                      FROM Payment_Webhook_Event__mdt 
                                                      WHERE MasterLabel =: event.event LIMIT 1];
            

            IRazorpayWebhookHandler handler;

            if (eventConfig != null && !String.isBlank(eventConfig.Logic_Implementer_Apex_Class__c)) {
                try {
                    Type handlerType = Type.forName(eventConfig.Logic_Implementer_Apex_Class__c);
                    if (handlerType != null) {
                        handler = (IRazorpayWebhookHandler) handlerType.newInstance();
                    } else {
                        handler = new RazorpayWebhookBaseHandler();
                    }
                } catch (Exception e) {
                    System.debug('⚠️ Could not instantiate Logic Implementer: ' + e.getMessage());
                    handler = new RazorpayWebhookBaseHandler();
                }
            } else {
                handler = new RazorpayWebhookBaseHandler();
            }

            // Call handler
            handler.handle(event);

            // Success response
            res.statusCode = 200;
            res.responseBody = Blob.valueOf('{"status": "success", "message": "Webhook processed successfully"}');
        }
        catch (Exception e) {
            System.debug('❌ Webhook processing error: ' + e.getMessage());
            res.statusCode = 500;
            res.responseBody = Blob.valueOf('{"error": "' + String.escapeSingleQuotes(e.getMessage()) + '"}');
        }
    }
}
