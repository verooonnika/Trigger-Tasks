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
        List<AccountCompositeResponse> responseList = AccountCompositeResponse.parse(response.getBody()); 
        
        for(Account account: accounts){
            account.External_Account_Id__c = responseList.get(accounts.indexOf(account)).id;
        }
        
        update accounts; 
    }
    
    @future(callout=true)
    public static void deleteRecord(List<Id> accountIds){
        String finalEndPoint = 'callout:Account_Sync/services/data/v50.0/composite/sobjects?ids=';
        
        for(Id accountId: accountIds){
            finalEndPoint = finalEndpoint + accountId + ',';
        }
        
        finalEndPoint = finalEndPoint.removeEnd(',');
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(finalEndPoint);
        request.setMethod('DELETE');
        HTTPResponse response = http.send(request);        
        
    }
    
    
    
}