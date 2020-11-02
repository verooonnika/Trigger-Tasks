public class AccountTriggerHandler {
    
    public void syncInsertAccount(List<Account> newAccounts){
        List<Id> accountIds = new List<Id>();
        for(Account account: newAccounts){
            if(account.External_Account_Id__c == null){
                accountIds.add(account.Id);
            }
        } 
        
        if(!accountIds.isEmpty()){
            System.enqueueJob(new SyncUpsertAccount(accountIds));
        }
        
    }
    
    public void syncUpdateAccount(Map<Id, Account> oldAccounts, Map<Id, Account> newAccounts){
        Boolean isFromApi = String.valueOf(System.URL.getCurrentRequestUrl().getPath()).contains('composite');
        
        Set<Id> accountIds = new Set<Id>();
        
         String[] fieldsToCompare = new String[]{'Name', 'AccountNumber', 'Phone', 
            'BillingCountry', 'BillingState', 'BillingCity', 'BillingStreet',
            'BillingPostalCode', 'BillingLatitude', 'BillingLongitude', 'ShippingCountry',
            'ShippingState', 'ShippingCity', 'ShippingStreet', 'ShippingPostalCode',
            'ShippingLatitude', 'ShippingLongitude'
            };
        
        if(isFromApi == false){
            for(Id accountId: newAccounts.keySet()){
                Account oldAccount = oldAccounts.get(accountId);
                Account newAccount = newAccounts.get(accountId);
                Boolean isFieldChanged = false; 
                
                for(String field : fieldsToCompare) {
                    if((String)newAccount.get(field) != (String)oldAccount.get(field)) {
                        accountIds.add(accountId);
                    }
                }
                
            } 
        }
        
        if(!accountIds.isEmpty()){
            List<Id> accountsToUpdate = new List<Id>(accountIds);
            System.enqueueJob(new SyncUpsertAccount(accountsToUpdate));

        }
    }
    
    public void syncDeleteAccount(List<Account> deletedAccounts){
        Boolean isFromApi = String.valueOf(System.URL.getCurrentRequestUrl().getPath()).contains('composite');
        
        List<Id> accountIds = new List<Id>();
        for(Account account: deletedAccounts){
            if(isFromApi == false){
                accountIds.add(account.External_Account_Id__c);
            }
        } 
        if(!accountIds.isEmpty()){
        	System.enqueueJob(new SyncDeleteAccount(accountIds));

        }
        
    }
    
}