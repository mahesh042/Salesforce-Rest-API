@RestResource(urlMapping='/Lead/*')
global with sharing class LeadEndpoint {

    @HttpGet
    global static List<Lead> receiveLeads() {
        return [SELECT Id, FirstName, LastName, Company,Score__c FROM Lead];
    }
    
    @HttpPost
    global static Lead createLead(String company1, String fname, String lname,Decimal Score1){
        Lead l = new Lead();
        l.Company = company1;
        l.FirstName = fname;
        l.LastName = lname;
        l.Score__c = Score1;
        
        insert l;
        return l;
    }
}