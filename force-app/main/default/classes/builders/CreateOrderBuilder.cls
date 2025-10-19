public with sharing class CreateOrderBuilder {

    private CreateOrderRequestEntity order;
    private RazorpayRequestBuilder request;

    public CreateOrderBuilder(RazorpayRequestBuilder request){
        this.order = new CreateOrderRequestEntity();
        this.request = request;
    }

    public CreateOrderBuilder setAmount(Integer amount){
        this.order.amount = amount;
        return this;
    }

    public CreateOrderBuilder setCurrency(String currencyValue){
        this.order.currencyValue = currencyValue;
        return this;
    }

    public CreateOrderBuilder setReceipt(String receipt){
        this.order.receipt = receipt;
        return this;
    }

    public CreateOrderBuilder setNotes(String key, String value){
        if(String.isNotBlank(key) && String.isNotBlank(value)) {
            this.order.notes.put(key, value);
        }
        return this;
    }

    public CreateOrderResponseEntity execute(){
        if (order.amount == null || order.currencyValue == null) {
            throw new RazorpayException('Missing required fields: amount, currency.');
        }

        String requestBody = JSON.serialize(order).replace('currencyValue', 'currency'); //As currency is a reserved value, we can't have currecy as property name in the entity.

        HttpResponse response = request.setEndpoint(RazorpayConstants.CREATE_ORDER_ENDPOINT)
               .setMethod('POST')
               .setBody(requestBody)
               .send();

        return convertToEntity(response);
    }

    private CreateOrderResponseEntity convertToEntity(HTTPResponse cloneResponse) {
        if (RazorpayConstants.HTTP_SUCCESS_STATUS_CODES.contains(cloneResponse.getStatusCode())) {
            return (CreateOrderResponseEntity) JSON.deserialize(cloneResponse.getBody(), CreateOrderResponseEntity.class);
        } else {
            throw new CalloutException(cloneResponse.getBody());
        }
    }
}