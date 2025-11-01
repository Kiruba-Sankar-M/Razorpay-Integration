public with sharing virtual class RazorpayOrderService {
    
    @AuraEnabled
    public static RazorpayOrderEntity createOrder(Integer amount, String currencyValue, String receipt, Map<String, String> notes){
        return new CreateOrderBuilder(amount, currencyValue)
                                        .setReceipt(receipt)
                                        .setNotes(notes)
                                        .execute();
    }

    @AuraEnabled
    public static RazorpayOrdersWithPaymentEntity fetchAllOrders(Integer count){
        return (RazorpayOrdersWithPaymentEntity) RazorpayGetRequestHelper.execute('RP_FETCH_ALL_ORDERS', new Map<String, String>{'{count}' => String.valueOf(count)});
    }

    @AuraEnabled
    public static RazorpayOrdersWithPaymentEntity fetchAllOrdersWithExpandedPayments(Integer count){
         return (RazorpayOrdersWithPaymentEntity) RazorpayGetRequestHelper.execute('RP_FETCH_ALL_ORDERS_WITH_PAYMENTS', new Map<String, String>{'{count}'=> String.valueOf(count)});
    }

    @AuraEnabled
    public static RazorpayOrdersWithPaymentEntity fetchAllOrdersWithExpandedCardPayments(Integer count){
         return (RazorpayOrdersWithPaymentEntity) RazorpayGetRequestHelper.execute('RP_FETCH_ALL_ORDERS_WITH_CARD_PAYMENTS', new Map<String, String>{'{count}'=> String.valueOf(count)});
    }

    @AuraEnabled
    public static RazorpayOrderEntity fetchOrderWithId(String orderId){
         return (RazorpayOrderEntity) RazorpayGetRequestHelper.execute('RP_ORDER_WITH_ID', new Map<String, String>{'{id}' => orderId});
    }

    @AuraEnabled
    public static RazorpayPaymentsEntity fetchPaymentsForAnOrder(String orderId){
         return (RazorpayPaymentsEntity) RazorpayGetRequestHelper.execute('RP_PAYMENTS_FOR_AN_ORDER', new Map<String, String>{'{order_id}' => orderId});
    }

}