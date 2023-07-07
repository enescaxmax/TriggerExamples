trigger studentTrigger on student__c (after update) {

    
    for(student__c  stnt : trigger.new){
        
        student__c oldVer = trigger.oldMap.get(stnt.id);
        
        if(stnt.send_to_goRest__c  &&  ( oldVer.send_to_goRest__c == false )       ) {
           
            CustomerGoRestPostCallout.postSFRecordToGoRestWithTrigger(stnt.id); 
            
        }
       
    }
    
    
    
}