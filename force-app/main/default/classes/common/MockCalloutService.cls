/**
 * @description       :
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-13-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/
public class MockCalloutService implements HttpCalloutMock {
    private final String DEFAULT_STATUS = 'Completed';
    private final Integer DEFAULT_STATUS_CODE = 200;
    private final Map<String, String> DEFAULT_HEADER = new Map<String, String>{
        'Content-Type' => 'application/json'
    };

    private String body;
    private Blob blobBody;
    private Map<String, String> header;
    private String status;
    private Integer statusCode;

    public MockCalloutService setBody(String body) {
        this.body = body;
        return this;
    }

    public MockCalloutService setBlobBody(Blob blobBody) {
        this.blobBody = blobBody;
        return this;
    }

    public MockCalloutService setHeader(Map<String, String> header) {
        this.header = header;
        return this;
    }

    public MockCalloutService setStatus(String status) {
        this.status = status;
        return this;
    }

    public MockCalloutService setStatusCode(Integer statusCode) {
        this.statusCode = statusCode;
        return this;
    }

    public HttpResponse respond(HttpRequest request) {
        this.header = this.header.isEmpty() ? DEFAULT_HEADER : this.header;
        this.status = this.status == null ? DEFAULT_STATUS : this.status;
        this.statusCode = this.statusCode == null
            ? DEFAULT_STATUS_CODE
            : this.statusCode;

        HttpResponse response = new HttpResponse();
        try {
            if (this.blobBody != null) {
                response.setBodyAsBlob(this.blobBody);
            } else {
                response.setBody(this.body);
            }

            for (String key : this.header.keySet()) {
                response.setHeader(key, this.header.get(key));
            }
            response.setStatusCode(this.statusCode);
            response.setStatus(this.status);
        } catch (Exception ex) {
            System.debug(LoggingLevel.ERROR, ex.getMessage());
        }

        return response;
    }
}
