public class PDFGenerator {
    
    private static final String PDF_FILE_NAME = 'Account Info ';
    
    @future(callout=true)
    public static void generatePDF(Id recordId){
        PageReference pdf = Page.AccountInfoTemplate;
        pdf.getParameters().put('id', recordId);
        
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
        attach.ParentId = recordId;
        
        insert attach;
        
    }
    
}