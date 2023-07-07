trigger AccountTrigger on Account (before insert , before update , before delete , after insert , after update, after delete, after undelete  ) {

    
    SWITCH on Trigger.operationType {
           
           WHEN BEFORE_INSERT  {
           for(Account accfromList : trigger.new){
      /**If an account is created 
           No matter what The rating of account should be ‘Hot’
           and BillingState should be ‘ARKANSAS’
        */          
               
                accfromList.Rating = 'Hot';
                accfromList.BillingState = 'ARKANSAS';
     /*
   Before creating an Account if the industry filed is null assign ‘Banking’ to Industry field
   bb*/
                if( accfromList.Industry == null) {
                      accfromList.Industry = 'Banking'; 
                   }
            }
           }
           WHEN BEFORE_UPDATE  { 
       /*      
           Before updating an Account assign ‘Education’ to Industry field if industry field is null
   
       */
          for(Account accfromList : trigger.new){
   
                if( accfromList.Industry == null) {
                      accfromList.Industry = 'Education'; 
                   }
            }
        
           }
           WHEN BEFORE_DELETE  { }
           WHEN AFTER_INSERT   { 
            List<Contact> cntList = new List<Contact>(); 
            for(Account accfromList : trigger.new){
                             
                 Contact cnt = new Contact();
                 cnt.LastName = 'AA AFTER INSERT';
                 cnt.AccountId = accfromList.id;
                 cntList.add(cnt);
           }
            insert cntList;
            
           }
           WHEN AFTER_UPDATE   { }
           WHEN AFTER_DELETE   { }
           WHEN AFTER_UNDELETE { }
    
       }
   
       
       
     /*  
       if (Trigger.isBefore &&  Trigger.isInsert ) {
             for(Account accfromList : trigger.new){
                accfromList.Rating = 'Hot';
                accfromList.BillingState = 'ARKANSAS';
            }
           system.debug('Trigger.operationType ==> ' +Trigger.operationType);
           system.debug('Trigger.size '+ Trigger.size);
       } 
    
        if (Trigger.isAFTER &&  Trigger.isInsert ) {
             
           List<Contact> cntList = new List<Contact>(); 
            for(Account accfromList : trigger.new){
                             
                 Contact cnt = new Contact();
                 cnt.LastName = 'AAA contact 2';
                 cnt.AccountId = accfromList.id;
                 cntList.add(cnt);
           }
            insert cntList;
             system.debug('Trigger.operationType ==> ' +Trigger.operationType);
             system.debug('Trigger.size '+ Trigger.size);
       } 
       
    */
       
   }