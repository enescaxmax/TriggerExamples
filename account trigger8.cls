trigger AccountTrigger on Account (before insert , before update , before delete , after insert , after update, after delete, after undelete  ) {


   
    
    
    SWITCH on Trigger.operationType {
           
           WHEN BEFORE_INSERT  {
           AccountTriggerBeforeHandler.beforeInsertHandler( Trigger.new   );
               
                /* While user creating an account if user provides Billing CITY but not Shipping CITY, 
               write a logic to populate shipping CITY with billing CITY 
               */
               for(Account acc : trigger.new){
                   
                   if (  acc.BillingCity != null  &&   acc.ShippingCity == null  ){
                       
                       acc.ShippingCity = acc.BillingCity ;
                   }
                  
                    
                  
                       
               } 
               
               
           }
           WHEN BEFORE_UPDATE  { 
      AccountTriggerBeforeHandler.beforeUpdateHandler( Trigger.new  );
     /*  Create a field named ‘Old Phone’ on account object
        Whenever phone field is updated on Account record
        Then Old Phone field should also get updated with old version of phone number on account 
    */            
               for( Account acc: trigger.new){
                  // Account  oldVersionAcc = trigger.oldMap.get(acc.id);
                 // acc.Old_Phones__c =  oldVersionAcc.phone;
                 
                   if (  trigger.oldMap.get(acc.id).phone  !=  acc.Phone  ) {
                       acc.Old_Phones__c =  trigger.oldMap.get(acc.id).phone;  
                   }
                  
               }            
               
                 // When the account’s billing city is updated, assign the previous billing City field of Account 
                 // to the mailing city field in the contacts of that account.
              Set<Id> accIdList = new Set<Id>();
               for( Account acc : trigger.new){
                   if ( acc.BillingCity  != trigger.oldMap.get(acc.id).BillingCity  ) {
                        accIdList.add(acc.id);
                       
                   }
                  
               }
           
               if ( accIdList.size() > 0  ) {
                   
                   List<Contact> cntList = [Select id ,MailingCity , account.billingcity  FROM contact WHERE accountId IN:accIdList];
                   for(contact cnt: cntList ){
                       cnt.MailingCity = cnt.account.billingcity;
                       
                   }  
                   database.update(cntList);
               }     
        
           }
           WHEN BEFORE_DELETE  { 
               for(Account acc : trigger.OLD){
                   
                   system.debug( acc.Name +    ' company is deleted');
                   
               }
           
           }
           WHEN AFTER_INSERT   { 
            AccountTriggerAfterHandler.afterInsertHandler( Trigger.new );
            
           }
           WHEN AFTER_UPDATE   {
                 // When the account’s billing city is updated, assign the previous billing City field of Account 
                 // to the mailing city field in the contacts of that account.
              Set<Id> accIdList = new Set<Id>();
               for( Account acc : trigger.new){
                   if ( acc.BillingCity  != trigger.oldMap.get(acc.id).BillingCity  ) {
                        accIdList.add(acc.id);
                       
                   }
                  
               }
           
               if ( accIdList.size() > 0  ) {
                   
                   List<Contact> cntList = [Select id ,MailingCity , account.billingcity  FROM contact WHERE accountId IN:accIdList];
                   for(contact cnt: cntList ){
                       cnt.MailingCity = cnt.account.billingcity;
                       
                   }  
                   database.update(cntList);
               }     
           
               
           }
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