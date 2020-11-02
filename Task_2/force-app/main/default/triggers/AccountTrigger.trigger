trigger AccountTrigger on Account (after insert, after update) {
    
    AccountTriggerHandler.generateAccountPDF(Trigger.New);    
    
}