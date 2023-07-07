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
        //  LeadTriggerHandler.industryFieldCheck (Trigger.new );
                
       // While creating a Lead assign ‘Other’ if Lead Source is null. (Before insert)
              for( Lead yeniLead: trigger.new){
                    if (yeniLead.LeadSource == null   ) {
                        
                        yeniLead.LeadSource = 'Other';
                    } 
                }
             
            }
            WHEN BEFORE_UPDATE  {
            //if Lead is updated, assign ‘Banking’ if Industry field is null
           /*      for( Lead yeniLead: trigger.new){
                    if(yeniLead.Industry == null   ) {
                        
                        yeniLead.Industry = 'Banking';
                    } 
                } 
                */
           
            //      LeadTriggerHandler.industryFieldCheck (Trigger.new );
           //     LeadTriggerHandler.statusCheck (trigger.new , Trigger.oldMap );
     
              
            }
            WHEN BEFORE_DELETE  { }
            WHEN AFTER_INSERT   {
           // LeadTriggerHandler.reqursionEngelleme(trigger.new);
           
                list<Task> taskList = new List<Task>();
                
                for(Lead yeniLead : Trigger.new){
                   
                    Task yeniTask = new Task();
                    yeniTask.subject = 'Yeni lead olustu lutfen iletisime geciniz';
                    yeniTask.OwnerId = yeniLead.OwnerId;
                  //   yeniTask.whatId = 'askjdfsaljfas';  lead objecti WHOID ye assign edilir 
                    yeniTask.WhoId  = yeniLead.Id;
                    
                    
                    
                    taskList.add(yeniTask);
                    
                }
           
            database.insert(taskList);
           
            }
            WHEN AFTER_UPDATE   { }
            WHEN AFTER_DELETE   { }
            WHEN AFTER_UNDELETE {
         /*   
                for(Lead coptenGelenLead : trigger.new){
                //   coptenGelenLead.Recycled__c = ' O geri geldi !!';   // after  trigger oldugunda record READ ONLY OLUR
                 system.debug( coptenGelenLead.id+ ' '+ coptenGelenLead.FirstName +  ' bu record copten cikarildi database kaydedildi');   
                }
            
            */
            }
     
        }
    
        
        
        
    }