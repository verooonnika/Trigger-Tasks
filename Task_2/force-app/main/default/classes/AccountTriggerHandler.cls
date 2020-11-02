public class AccountTriggerHandler {
    
    public static void generateAccountPDF(List<Account> accounts){
        for(Account account: accounts){
            if(account.PDF_Info__c == true){
                PDFGenerator.generatePDF(account.Id);
                Account changedAccount = [SELECT Id, PDF_Info__c FROM Account WHERE Id =: account.Id];
            }
        }
    }
    
}