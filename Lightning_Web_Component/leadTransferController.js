// leadTransferController.js
import { LightningElement, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createLeadInTargetOrg from '@salesforce/apex/LeadTransferController.createLeadInTargetOrg';

export default class LeadTransferController extends LightningElement {
    transferLeads() {
        createLeadInTargetOrg()
            .then(result => {
                this.showToast('Success', 'Leads transferred successfully', 'success');
            })
            .catch(error => {
                this.showToast('Error', 'Error transferring leads: ' + error.body.message, 'error');
            });
    }

    showToast(title, message, variant) {
        const toastEvent = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(toastEvent);
    }
}