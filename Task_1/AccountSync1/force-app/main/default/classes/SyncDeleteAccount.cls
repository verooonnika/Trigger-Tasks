public class SyncDeleteAccount implements Queueable, Database.AllowsCallouts {
    
    List<Id> accountIds;
    
      public SyncDeleteAccount(List<Id> ids) {
          accountIds = ids;
        
    }
    
    public void execute(QueueableContext context){
        RestCallout.deleteRecord(accountIds);
    }
    
}