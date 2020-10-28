public class AccountTriggerHandler {
    
    public void syncInsertAccount(List<Account> newAccounts){
        for(Account account: newAccounts){
            if(account.External_Account_Id__c == null){
               // RestCallout.sendRecord(account.Id);
            }
        } 
    }
    
    public void syncUpdateAccount(List<Account> newAccounts){
        for(Account account: newAccounts){
           // RestCallout.sendRecord(account.Id);
        } 
    }
    
}