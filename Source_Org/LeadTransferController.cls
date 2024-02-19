public class LeadTransferController {
    @future(callout=true)
    @AuraEnabled
    public static void getDetails() {
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:TargetOrg/services/apexrest/Lead/');
        req.setHeader('content-type','application/json; charset=UTF-8');
        req.setHeader('Accept','application/json');
        req.setMethod('GET');
        Http http = new Http();
        HttpResponse response = http.send(req);
        
        System.debug('response code: ' + response.getStatusCode());
        System.debug('response body: ' + response.getBody());
    }

    @future(callout=true)
    @AuraEnabled
    public static void createLeadInTargetOrg() {
        
        List<Lead> leads = [SELECT FirstName, LastName, Company,Score__c FROM Lead WHERE Score__c > 50];
    
        for (Lead lead : leads) {
            Map<String, Object> leadMap = new Map<String, Object>{
                'fname' => lead.FirstName,
                'lname' => lead.LastName,
                'company1' => lead.Company,
                'Score1' => lead.Score__c
           
            };
    
            String payload = JSON.serialize(leadMap);
    
            HttpRequest req = new HttpRequest();
            req.setEndpoint('callout:TargetOrg/services/apexrest/Lead/');
            req.setHeader('content-type','application/json; charset=UTF-8');
            req.setHeader('Accept','application/json');
            req.setBody(payload);
            req.setMethod('POST');
    
            Http http = new Http();
            HttpResponse response = http.send(req);
    
            System.debug('response code: ' + response.getStatusCode());
            System.debug('response body: ' + response.getBody());
        }
    }


    public static void scheduleCallout() {
        System.enqueueJob(new CalloutJob());
    }

    public class CalloutJob implements System.Queueable {
        public void execute(System.QueueableContext context) {
            createLeadInTargetOrg();
        }
    }
}