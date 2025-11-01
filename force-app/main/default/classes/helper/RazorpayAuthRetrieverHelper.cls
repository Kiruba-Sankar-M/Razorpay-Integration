public class RazorpayAuthRetrieverHelper {
    public static String getNamedCredential() {
        System.debug('Entering');
        String authOverrideClass = Payment_Gateway_Config__mdt.getInstance('Razorpay_Config').Auth_Overriding_Apex_Class__c;
        System.debug('authOverrideClass ' + authOverrideClass);
        if (authOverrideClass != NULL && !String.isEmpty(authOverrideClass)) {
            Type t = Type.forName(authOverrideClass);

            if (t == null) {
                throw new RazorpayException('Invalid Apex class name: ' + authOverrideClass);
            }

            // Check if the class extends RazorpayAuth
            if (!RazorpayAuth.class.isAssignableFrom(t)) {
                throw new RazorpayException('The class ' + authOverrideClass + ' must extend RazorpayAuth.');
            }

            RazorpayAuth auth = (RazorpayAuth) t.newInstance();
            return auth.getNamedCredential();

        } else {
            return new RazorpayAuth().getNamedCredential();
        }
    }
}
