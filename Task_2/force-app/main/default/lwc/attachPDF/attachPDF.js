import { LightningElement, api, track } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import ID_FIELD from '@salesforce/schema/Account.Id';
import CREATE_PDF_FIELD from '@salesforce/schema/Account.PDF_Info__c';

export default class attachPDF extends LightningElement {
    @api recordId;

    @track message;
    @track loading;

    connectedCallback()
    {
        this.loading = true;
        this.updateAccount();
    }

    updateAccount(){
        const fields = {};
        fields[ID_FIELD.fieldApiName] = this.recordId;
        fields[CREATE_PDF_FIELD.fieldApiName] = true;
 
        const recordInput = {fields};
        updateRecord(recordInput)
        .then(() => {
            this.loading = false;
            this.message = 'Pdf created!';
        })
        .catch(error => {
            this.loading = false;
            this.message = error;
        });
    }
}