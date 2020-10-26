public class RestCallout {
    
    private static final String SEND_RECORD_ENDPOINT = 'callout:Account_Sync/services/data/v50.0/composite';
    
    public static HttpResponse sendRecord(){
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SEND_RECORD_ENDPOINT);
        request.setHeader('Content-Type', 'application/json');       
        request.setMethod('POST');
        HTTPResponse response = http.send(request);
        System.debug(response);
        return response;
    }
    
}