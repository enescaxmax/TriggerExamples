trigger OpportunityTrigger on Opportunity (before insert , before update , before delete , after insert , after update, after delete, after undelete) {
    SWITCH on Trigger.operationType {
            
            WHEN BEFORE_INSERT  { 
            // Populate Opportunity description (‘Test purpose Opportunity ‘ ) when user creates Opportunity 
              
                for(Opportunity   opp : Trigger.new){
                    opp.Description = 'Test purpose Opportunity!!! ';
                 
                }
                
               
            }
            WHEN BEFORE_UPDATE  { }
            WHEN BEFORE_DELETE  { 
            
         
            
            
            
            }
            WHEN AFTER_INSERT   { }
            WHEN AFTER_UPDATE   { }
            WHEN AFTER_DELETE   { }
            WHEN AFTER_UNDELETE {
           
    
            
            }
     
        }
    
    }