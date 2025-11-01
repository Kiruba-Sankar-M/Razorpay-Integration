public class RazorpayResponseToEntityTransformHelper {
    public static RazorpayBaseEntity transform(HttpResponse response, String apexClass){
        String body = response.getBody().toString();
        Type entity = Type.forName(apexClass);

        if (entity == null) {
            throw new RazorpayException('Invalid Apex class name: ' + apexClass);
        }

        if (!RazorpayBaseEntity.class.isAssignableFrom(entity)) {
            throw new RazorpayException('The class ' + apexClass + ' must extend RazorpayBaseEntity.');
        }

        body = RazorpayResponseBodyTransformHelper.transform(body);
        
        return (RazorpayBaseEntity) JSON.deserialize(
            body,
            entity
        );
    }
}