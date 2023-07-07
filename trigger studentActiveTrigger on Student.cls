trigger studentActiveTrigger on Student__c (after insert , after update, after delete, after undelete) {
SWITCH on Trigger.operationType {
    
       WHEN BEFORE_INSERT { }
       WHEN BEFORE_UPDATE { }                
       WHEN BEFORE_DELETE { }
       WHEN AFTER_INSERT  {
       
           studentActiveHandler.activeStudents(trigger.new);
           
       
       }       
       WHEN AFTER_UPDATE  {
       
                  studentActiveHandler.activeStudents(trigger.new);
}
       WHEN AFTER_DELETE  {
       
                  studentActiveHandler.activeStudents(trigger.old);
}
       WHEN AFTER_UNDELETE { 
           
                  studentActiveHandler.activeStudents(trigger.new);
}
   }
}