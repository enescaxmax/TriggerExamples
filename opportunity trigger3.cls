trigger OpportunityTrigger on Opportunity (before insert , before update , before delete , after insert , after update, after delete, after undelete) {
    SWITCH on Trigger.operationType {
            
            WHEN BEFORE_INSERT  { 
            // Populate Opportunity description (‘Test purpose Opportunity ‘ ) when user creates Opportunity 
            
                for(Opportunity   opp : Trigger.new){
                    opp.Description = 'Test purpose Opportunity!!! ';
                 
                }
                
               
            }
            WHEN BEFORE_UPDATE  {
                for(opportunity opp : trigger.new){
                    opp.Description = System.userInfo.getFirstName()  + ' yes baby you updated the record!! on ' + system.today();
                   
                }
            
            }
            WHEN BEFORE_DELETE  { 
               
                for (Opportunity opp:Trigger.old){
                    If(  opp.stageName == 'Closed Won') {
                      opp.addError(' You can not delete won deals');
                    }
                }
     
                
                
        }
            WHEN AFTER_INSERT   { }
            WHEN AFTER_UPDATE   { 
            
    List<Task> taskList = new List<task>();
    
        for (Opportunity opp:Trigger.new){
                If(  opp.stageName == 'Negotiation/Review'    &&   Trigger.oldMap.get(opp.Id). stageName != 'Negotiation/Review'  ) {
                 Task taskForOwner = new  Task();
                 taskForOwner.Subject = 'Stage is updated';
                 taskForOwner.OwnerId = opp.OwnerId;
                 taskForOwner.WhatId= opp.Id;
                 taskList.add(taskForOwner );
                }
          }
      Database.Insert(taskList );
            
            }
            WHEN AFTER_DELETE   { }
            WHEN AFTER_UNDELETE {
           
    
            
            }
     
        }
    
    }