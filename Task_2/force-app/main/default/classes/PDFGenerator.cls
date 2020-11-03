public class PDFGenerator implements Queueable, Database.AllowsCallouts {
    
    private static final String PDF_FILE_NAME = 'Account Info ';

    List<Id> accountIds;

    public PDFGenerator(List<Id> ids){
        accountIds = ids;

    }
    
    public void execute(QueueableContext context){
        List<Attachment> filesToAttach = new List<Attachment>();

        for(Id accountId: accountIds){
            PageReference pdf = Page.AccountInfoTemplate;
            pdf.getParameters().put('id', accountId);
            
            Attachment attach = new Attachment();
            Blob body;
            
            try {
                body = pdf.getContentAsPDF();
                
            } catch (VisualforceException e) {
                body = Blob.valueOf('Error');
            }
            
            attach.Body = body;
            attach.Name = PDF_FILE_NAME + System.now() + '.pdf';
            attach.IsPrivate = false;
            attach.ParentId = accountId;
            filesToAttach.add(attach);
        }
       
        
        insert filesToAttach;
        
    }
    
}