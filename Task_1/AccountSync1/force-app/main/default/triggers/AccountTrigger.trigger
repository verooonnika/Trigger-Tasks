trigger AccountTrigger on Account (after insert, after update, before delete) {
    
    if(Trigger.isInsert){
        for(Account account: Trigger.New){
            RestCallout.sendRecord(account.Id);
        } 
        
    }
    
    if(Trigger.isDelete){
        for(Account account: Trigger.Old){
            RestCallout.deleteRecord(account.Id);
        }
        
    }
    
    
    
    
    
}