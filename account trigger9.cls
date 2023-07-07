trigger AccountTrigger on Account (before insert , before update , before delete , after insert , after update, after delete, after undelete  ) {

    
    SWITCH on Trigger.operationType {
           
           WHEN BEFORE_INSERT  {
           AccountTriggerBeforeHandler.beforeInsertHandler( Trigger.new   );
           }
           WHEN BEFORE_UPDATE  { 
      AccountTriggerBeforeHandler.beforeUpdateHandler( Trigger.new  );
        
           }
           WHEN BEFORE_DELETE  { 
               for(Account acc : trigger.OLD){
                   
                   system.debug( acc.Name +    ' company is deleted');
                   
               }
           
           }
           WHEN AFTER_INSERT   { 
            AccountTriggerAfterHandler.afterInsertHandler( Trigger.new );
            
           }
           WHEN AFTER_UPDATE   { }
           WHEN AFTER_DELETE   { }
           WHEN AFTER_UNDELETE { 
            List<Contact> cntList = [SELECT Id, AccountId, Description FROM Contact  WHERE AccountId IN:Trigger.newMap.keySet()]; 
   
          For(Contact cnt : cntList ) {
            Cnt.Description = 'Account restored by'  + System.UserInfo.getName() + ', on' + system.today();
           }
         Database.update(cntList );
           
           }
    
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