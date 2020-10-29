trigger AccountTrigger on Account (after insert, before update, before delete) {
    
    AccountTriggerHandler handler = new AccountTriggerHandler();
    
    if(Trigger.isInsert){
        handler.syncInsertAccount(Trigger.new);
    }
    
    if(Trigger.isUpdate){
        handler.syncUpdateAccount(Trigger.oldMap, Trigger.newMap);
    }
    
    if(Trigger.isDelete){
        for(Account account: Trigger.Old){
            handler.syncDeleteAccount(Trigger.old);
        }
        
    }
    
}