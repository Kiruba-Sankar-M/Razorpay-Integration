public with sharing class RazorpayConstants {
    public static final String CREATE_ORDER_ENDPOINT =  '/orders';
    public static final String CREATE_CUSTOMER_ENDPOINT =  '/customers';

    public static final List<Integer> HTTP_SUCCESS_STATUS_CODES = new List<Integer>{200, 201, 204};
    public static final List<Integer> HTTP_INTERRUPTED_STATUS_CODES = new List<Integer>{503, 308};
    public static final Integer HTTP_UNAUTHORIZED_STATUS_CODE = 401;
}