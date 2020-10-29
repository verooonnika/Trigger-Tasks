public class AccountHandler {
    
    public static List<Account> getAccountsById(List<Id> accountIds){
        return [SELECT Name, Phone, AccountNumber, BillingCountry, BillingState,
                BillingCity, BillingStreet, BillingPostalCode, BillingLatitude,
                BillingLongitude, ShippingCountry, ShippingState, ShippingCity,
                ShippingStreet, ShippingPostalCode,ShippingLatitude, ShippingLongitude
                FROM Account
                WHERE Id IN: accountIds];
        
    }
    
    public static List<Account> createAccountsForRequest(List<Account> originalAccounts){
        String[] fields = new String[]{'Name', 'AccountNumber', 'Phone', 
            'BillingCountry', 'BillingState', 'BillingCity', 'BillingStreet',
            'BillingPostalCode', 'BillingLatitude', 'BillingLongitude', 'ShippingCountry',
            'ShippingState', 'ShippingCity', 'ShippingStreet', 'ShippingPostalCode',
            'ShippingLatitude', 'ShippingLongitude'
            };
                
        List<Account> accountsForRequest = new List<Account>();
        
        for(Account account: originalAccounts){
            Account accountForRequest = new Account();
            for(String field: fields){
                accountForRequest.put(field, account.get(field));
            }
            accountForRequest.External_Account_Id__c = account.Id;
            accountsForRequest.add(accountForRequest);
        }
        
        return accountsForRequest;
        
        
    }
    
}