trigger Lead_Trigger on Lead (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        for(Lead a:Trigger.new){
            if(a.State__c!=null && a.LeadSource== 'website'){
                a.State=a.State__c;
            }
        }
    }
}