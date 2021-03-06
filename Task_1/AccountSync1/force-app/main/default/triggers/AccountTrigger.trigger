trigger AccountTrigger on Account (after insert, before update, before delete) {
    
    AccountTriggerHandler handler = new AccountTriggerHandler();
    
    if(Trigger.isInsert){
        handler.syncInsertAccount(Trigger.new);
    }
    
    if(Trigger.isUpdate){
        handler.syncUpdateAccount(Trigger.oldMap, Trigger.newMap);
    }
    
    if(Trigger.isDelete){
        handler.syncDeleteAccount(Trigger.old);
        
    }
    
}