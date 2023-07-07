trigger AccountTrigger on Account (before insert , before update , before delete , after insert , after update, after delete, after undelete  ) {

    
    SWITCH on Trigger.operationType {
           
           WHEN BEFORE_INSERT  {
           for(Account accfromList : trigger.new){
                accfromList.Rating = 'Hot';
                accfromList.BillingState = 'ARKANSAS';
            }
           system.debug('Trigger.operationType ==> ' +Trigger.operationType);
           system.debug('Trigger.size '+ Trigger.size);
           }
           WHEN BEFORE_UPDATE  { }
           WHEN BEFORE_DELETE  { }
           WHEN AFTER_INSERT   { 
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