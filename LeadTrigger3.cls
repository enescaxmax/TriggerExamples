trigger LeadTrigger on Lead (before insert , before update , before delete , after insert , after update, after delete, after undelete) {

    SWITCH on Trigger.operationType {
            
            WHEN BEFORE_INSERT  {
        //When a new Lead is created assign ‘Education’  if Industry field is null
        /*        for( Lead yeniLead: trigger.new){
                    if (yeniLead.Industry == null   ) {
                        
                        yeniLead.Industry = 'Education';
                    } 
                }  
                */
     LeadTriggerHandler.industryFieldCheck (Trigger.new );
                
            
            }
            WHEN BEFORE_UPDATE  {
            //if Lead is updated, assign ‘Banking’ if Industry field is null
           /*      for( Lead yeniLead: trigger.new){
                    if(yeniLead.Industry == null   ) {
                        
                        yeniLead.Industry = 'Banking';
                    } 
                } 
                */
           
          LeadTriggerHandler.industryFieldCheck (Trigger.new );
                       
                
            }
            WHEN BEFORE_DELETE  { }
            WHEN AFTER_INSERT   { }
            WHEN AFTER_UPDATE   { }
            WHEN AFTER_DELETE   { }
            WHEN AFTER_UNDELETE { }
     
        }
    
        
        
        
    }