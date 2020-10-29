public class AccountTriggerHandler {
    
    public void syncInsertAccount(List<Account> newAccounts){
        List<Id> accountIds = new List<Id>();
        for(Account account: newAccounts){
            if(account.External_Account_Id__c == null){
                accountIds.add(account.Id);
            }
        } 
        if(!accountIds.isEmpty()){
            RestCallout.sendRecord(accountIds);
        }
        
    }
    
    public void syncUpdateAccount(Map<Id, Account> oldAccounts, Map<Id, Account> newAccounts){
        Boolean isFromApi = String.valueOf(System.URL.getCurrentRequestUrl().getPath()).contains('composite');
        
        List<Id> accountIds = new List<Id>();
        for(Id accountId: newAccounts.keySet()){
            Account oldAccount = oldAccounts.get(accountId);
            Account newAccount = newAccounts.get(accountId);
            if(oldAccount.Name != newAccount.Name && isFromApi == false){
                accountIds.add(accountId);
            }
        } 
        if(!accountIds.isEmpty()){
            RestCallout.sendRecord(accountIds);
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
            RestCallout.deleteRecord(accountIds);
        }
        
    }
    
}