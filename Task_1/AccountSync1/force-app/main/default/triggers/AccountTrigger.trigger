trigger AccountTrigger on Account (after insert, after update, before delete) {
    
    AccountTriggerHandler handler = new AccountTriggerHandler();
    
    /*if(Trigger.isInsert){
        handler.syncInsertAccount(Trigger.New);
    }*/
    
    if(Trigger.isDelete){
        for(Account account: Trigger.Old){
            RestCallout.deleteRecord(account.Id);
        }
        
    }
    
    
    
    
    
}