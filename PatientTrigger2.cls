trigger PatientTrigger on Patient__c (before insert , before update , before delete , after insert , after update, after delete, after undelete) {
    SWITCH on Trigger.operationType {
            
            WHEN BEFORE_INSERT  {}
            WHEN BEFORE_UPDATE  {}
            WHEN BEFORE_DELETE  {}
            WHEN AFTER_INSERT   {
            /*
             List<Patient__share> shareList = new  List<Patient__share>();           
              
                for(Patient__c patient : trigger.new){
                // for Doctor    
                    Patient__share share= new Patient__share();
                    share.ParentId      = patient.id;
                    share.UserOrGroupId = patient.Doctor__c;
                   //  share.UserOrGroupId = patient.Nurse__c;
                    share.AccessLevel  = 'Edit';
                    share.RowCause     = 'Manual';
                    
                    shareList.add(share);
              
                    // nurse
                 Patient__share share2= new Patient__share();
                    share2.ParentId      = patient.id;
                  //  share2.UserOrGroupId = patient.Doctor__c;
                    share2.UserOrGroupId = patient.Nurse__c;
                    share2.AccessLevel  = 'Edit';
                    share2.RowCause     = 'Manual';
                    
                    shareList.add(share2);                
                }
            
             insert shareList; */
              // 1 option   
             // PatientTriggerHandler.createShareRecords(Trigger.new );  
               
                // 2 . option
                
             List<Patient__share> shareList = new  List<Patient__share>();           
              
                for(Patient__c patient : trigger.new){
                    // doctor
                     shareList.add( PatientTriggerHandler.createSingleShareRecord( patient.id , patient.doctor__c  )) ;
                 
                    // nurse
                     shareList.add( PatientTriggerHandler.createSingleShareRecord(patient.id, patient.nurse__c  ) ) ;   
                                 
                }
            
             insert shareList;             
                
                
            }
            WHEN AFTER_UPDATE   { }
            WHEN AFTER_DELETE   { }
            WHEN AFTER_UNDELETE {}
     
        }
    
        
        
    }