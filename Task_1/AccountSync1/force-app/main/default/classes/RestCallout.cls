public class RestCallout {
    
    private static final String SEND_RECORD_ENDPOINT = 'callout:Account_Sync/services/data/v50.0/sobjects/Account/';
    
    //upsert
    @future(callout=true)
    public static void sendRecord(Id accountId){
        
        Account account = [SELECT Id, Name FROM Account WHERE Id =: accountId LIMIT 1];
        
        Account accountToSend = new Account(Name = account.Name);
        
        String finalEndPoint = SEND_RECORD_ENDPOINT + 'External_Account_Id__c/' + accountId + '?_HttpMethod=PATCH';
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(finalEndPoint);
        request.setHeader('Content-Type', 'application/json');
        request.setMethod('POST');
        request.setBody(JSON.serialize(accountToSend));
        
        HTTPResponse response = http.send(request);
        Map <String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        account.External_Account_Id__c = (String)responseMap.get('id');
        update account;
    }
    
    @future(callout=true)
    public static void deleteRecord(Id accountId){
        Account account = [SELECT Id, Name, External_Account_Id__c FROM Account WHERE Id =: accountId LIMIT 1];
        String finalEndPoint = SEND_RECORD_ENDPOINT + account.External_Account_Id__c;
        
        HttpRequest request = new HttpRequest();
        request.setEndpoint(finalEndPoint);
        request.setMethod('DELETE');
        
        
    }
    
    
    
}