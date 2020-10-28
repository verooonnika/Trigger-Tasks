public class RestCallout {
    
    private static final String SEND_RECORD_ENDPOINT = 'callout:Account_Sync/services/data/v50.0/composite/sobjects/Account/';
    
    //upsert
    @future(callout=true)
    public static void sendRecord(List<Id> accountIds){
        
        List<Account> accounts = [SELECT Name, Phone FROM Account WHERE Id IN: accountIds];
        List<Account> accountsToSend = new List<Account>();
        
        for(Account account: accounts){
            Account accountToSend = new Account(name = account.Name, External_Account_Id__c = account.Id);
            accountsToSend.add(accountToSend);
        }
        
        AccountCompositeRequest requestBody = new AccountCompositeRequest(accountsToSend);
        
        String finalEndPoint = SEND_RECORD_ENDPOINT + 'External_Account_Id__c' + '?_HttpMethod=PATCH';
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(finalEndPoint);
        request.setHeader('Content-Type', 'application/json');
        request.setMethod('POST');
        request.setBody(Json.serialize(requestBody));
        
        HTTPResponse response = http.send(request);
        System.debug(response.getBody());
        /* Map <String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
account.External_Account_Id__c = (String)responseMap.get('id');
update account; */
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