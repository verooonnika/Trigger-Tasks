public class AccountTriggerHandler {
    
    public static void generateAccountPDF(List<Account> accounts){
        List<Id> accountsToPDF = new List<Id>();
        for(Account account: accounts){
            if(account.PDF_Info__c == true){
                accountsToPDF.add(account.Id);
            }
        }
        System.enqueueJob(new PDFGenerator(accountsToPDF));
        uncheckPdfField(accountsToPDF);
    }

    public static void uncheckPdfField(List<Id> accountIds){
        List<Account> accounts = [SELECT Id, PDF_Info__c FROM Account WHERE Id IN: accountIds];
        for(Account account: accounts){
            account.PDF_Info__c = false;
        }
      
        update accounts;
    }
    
}