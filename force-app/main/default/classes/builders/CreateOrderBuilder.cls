public with sharing class CreateOrderBuilder {

    private RazorpayOrderEntity order;

    public CreateOrderBuilder(Integer amount, String currencyValue){
        this.order = new RazorpayOrderEntity();
        this.order.amount = amount;
        this.order.currencyValue = currencyValue;
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

    public CreateOrderBuilder setNotes(Map<String, String> notes){
        if(notes == null || notes.isEmpty()) return this;
        this.order.notes.putAll(notes);
        return this;
    }

    public RazorpayOrderEntity execute(){
        Map<String, Object> body = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(this.order));
        return (RazorpayOrderEntity) RazorpayPostRequestHelper.execute('RP_CREATE_ORDER', NULL, body);
    }   
}