trigger LeadTrigger on Lead (before insert , before update , before delete , after insert , after update, after delete, after undelete) {

    SWITCH on Trigger.operationType {
       
       WHEN BEFORE_INSERT  {
     LeadTriggerBeforeHandler.beforeInsertHandler( Trigger.new );
       
       }
       WHEN BEFORE_UPDATE  { 
     LeadTriggerBeforeHandler.beforeUpdateHandler( Trigger.new);   
           
       }
       WHEN BEFORE_DELETE  { }
       WHEN AFTER_INSERT   {
       
   LeadTriggerAfterHandler.recursionExample(Trigger.New);
       
       }
       WHEN AFTER_UPDATE   { }
       WHEN AFTER_DELETE   { }
       WHEN AFTER_UNDELETE { }

   }
   
}