public with sharing class RazorpayResponseBodyTransformHelper {
    public static String transform(String body) {
        body = body.trim();
        body = body.replaceAll('"notes"\\s*:\\s*\\[\\s*\\]', '"notes":{}');
        body = body.replaceAll('"currency"', '"currencyValue"');
        body = body.replaceAll('"end"', '"endValue"');
        body = body.replaceAll('"begin"', '"beginValue"');
        return body;
    }
}