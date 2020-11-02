public class SyncUpsertAccount implements Queueable, Database.AllowsCallouts {
    
    List<Id> accountIds;
    
      public SyncUpsertAccount(List<Id> ids) {
          accountIds = ids;
        
    }
    
    public void execute(QueueableContext context){
        RestCallout.sendRecord(accountIds);
    }
    
}