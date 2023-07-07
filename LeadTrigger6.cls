trigger LeadTrigger on Lead (before insert , before update , before delete , after insert , after update, after delete, after undelete) {

    SWITCH on Trigger.operationType {
       
       WHEN BEFORE_INSERT  {
     LeadTriggerBeforeHandler.beforeInsertHandler( Trigger.new );
      
                
       }
       WHEN BEFORE_UPDATE  { 
     LeadTriggerBeforeHandler.beforeUpdateHandler( Trigger.new);   
   //Create an error (Warning) trigger when a Lead is updated from 'Open - Not Contacted' status
   // to 'Closed - Converted' or 'Closed - Not Converted' status. (Validation )
  
           for(Lead newLd : Trigger.new){
             
         Lead oldLead   =   Trigger.oldMap.get(newLd.id);
               
               
                   if( oldLead.Status=='Open - Not Contacted' && (newLd.Status == 'Closed - Converted' || newLd.Status == 'Closed - Not Converted')  )  {
                       
                       newLd.addError(' you can not edit the status ');
                       
                   }   
                   
                   
                   
           }  
           
             
       }
       WHEN BEFORE_DELETE  { }
       WHEN AFTER_INSERT   {
       
   LeadTriggerAfterHandler.recursionExample(Trigger.New);
       
       }
       WHEN AFTER_UPDATE   { }
       WHEN AFTER_DELETE   { }
       WHEN AFTER_UNDELETE {
       
           for( Lead cherry : trigger.new){
              cherry.Recycled__c= ' restored';
             // system.debug(' your record is restored'); 
           }
       
       }

   }
   
}