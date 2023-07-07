public class PatientTriggerHandler {

    // 1. option 
      public static VOID createShareRecords(List<Patient__c> patientsList    ){
          
           List<Patient__share> shareList = new  List<Patient__share>();           
            
              for(Patient__c patient : patientsList){
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
          
           insert shareList;   
          
      }
      
      
      // 2. option
      
       public static Patient__share createSingleShareRecord(ID patient , ID userId   ){
          
             
                  Patient__share share= new Patient__share();
                  share.ParentId      = patient;
                  share.UserOrGroupId =  userId ;
                  share.AccessLevel  = 'Edit';
                  share.RowCause     = 'Manual';
        
           
             return share;
      }
      
      
      
  }