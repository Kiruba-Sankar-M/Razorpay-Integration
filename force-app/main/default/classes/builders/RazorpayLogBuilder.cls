public virtual class RazorpayLogBuilder {
    private SObject so;
    public RazorpayLogBuilder(String sObjectName){ 
        so = Schema.getGlobalDescribe().get(sObjectName).newSObject();
    } 

    public virtual RazorpayLogBuilder logRequest(HttpRequest request, HttpResponse response){
        return this;
    }

    public virtual RazorpayLogBuilder logBody(HttpRequest request, String field){
        so.put(field, request.getBody());
        return this;
    }
}