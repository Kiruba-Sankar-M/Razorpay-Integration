public with sharing class RazorpayConstants {
    //Order Endpoints
    public static final String CREATE_ORDER_ENDPOINT =  '/orders';
    public static final String FETCH_ALL_ORDERS = '/orders?count=';
    public static final String FETCH_ALL_ORDERS_WITH_PAYMENTS = '/orders?expand[]=payments&count=';
    public static final String FETCH_ALL_ORDERS_WITH_CARD_PAYMENTS = '/orders?expand[]=payments.card&count=';
    public static final String FETCH_ORDER_WITH_ID = '/orders/';

    public static final String CREATE_CUSTOMER_ENDPOINT =  '/customers';

    public static final List<Integer> HTTP_SUCCESS_STATUS_CODES = new List<Integer>{200, 201, 204};
    public static final List<Integer> HTTP_INTERRUPTED_STATUS_CODES = new List<Integer>{503, 308, 400, 401};
}