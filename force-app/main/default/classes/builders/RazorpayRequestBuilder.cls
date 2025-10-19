public with sharing class RazorpayRequestBuilder {

    private String endpoint;
    private String method;
    private Map<String, String> headers;
    private Map<String, String> parameters;
    private String bodyAsString;
    private Blob bodyAsBlob;
    private String namedCredential;

    public RazorpayRequestBuilder(String namedCredential) {
        this.namedCredential = namedCredential;
        this.headers = new Map<String, String>();
        this.parameters = new Map<String, String>();
    }

    public RazorpayRequestBuilder setEndpoint(String endpoint) {
        this.endpoint = this.namedCredential + endpoint;
        return this;
    }

    public RazorpayRequestBuilder setMethod(String method) {
        this.method = method;
        return this;
    }

    public RazorpayRequestBuilder setHeader(String key, String value) {
        this.headers.put(key, value);
        return this;
    }

    public RazorpayRequestBuilder setHeader(String key, Integer value) {
        this.headers.put(key, String.valueOf(value));
        return this;
    }

    public RazorpayRequestBuilder setParameter(String key, String value) {
        this.parameters.put(key, EncodingUtil.urlEncode(value, 'UTF-8'));
        return this;
    }

    public RazorpayRequestBuilder setParameter(String key, Integer value) {
        this.parameters.put(key, EncodingUtil.urlEncode(String.valueOf(value), 'UTF-8'));
        return this;
    }

    public RazorpayRequestBuilder setParameter(String key, Boolean value) {
        this.parameters.put(key, EncodingUtil.urlEncode(String.valueOf(value), 'UTF-8'));
        return this;
    }

    public RazorpayRequestBuilder removeParameter(String key) {
        this.parameters.remove(key);
        return this;
    }

    public RazorpayRequestBuilder setBody(String body) {
        this.bodyAsString = body;
        return this;
    }

    public RazorpayRequestBuilder setBody(Blob body) {
        this.bodyAsBlob = body;
        return this;
    }

    public HTTPResponse send() {
        HttpRequest req = new HttpRequest();
        req.setMethod(this.method);

        this.buildEndpointUrl(req);
        this.buildEndpointHeaders(req);
        this.buildEndpointBody(req);

        Http http = new Http();
        return http.send(req);
    }

    private void buildEndpointUrl(HttpRequest req) {
        List<String> parameterKeys = new List<String>(this.parameters.keySet());
        for (Integer i = 0; i < parameterKeys.size(); i++) {
            String parameterKey = parameterKeys.get(i);
            String parameterValue = this.parameters.get(parameterKey);

            if (i == 0) {
                this.endpoint += ('?' + parameterKey + '=' + parameterValue);
            } else {
                this.endpoint += ('&' + parameterKey + '=' + parameterValue);
            }
        }
        req.setEndpoint(this.endpoint);
    }

    private void buildEndpointHeaders(HttpRequest req) {
        for (String headerKey : this.headers.keySet()) {
            String headerParameter = this.headers.get(headerKey);
            req.setHeader(headerKey, headerParameter);
        }
    }


    private void buildEndpointBody(HttpRequest req) {
        if (String.isNotBlank(this.bodyAsString)) {
            req.setBody(this.bodyAsString);
        } else if (this.bodyAsBlob != null) {
            req.setBodyAsBlob(this.bodyAsBlob);
        }
    }
    
}