trigger AccountTrigger on Account (before insert , before update , before delete , after insert , after update, after delete, after undelete ) {

    SWITCH on Trigger.operationType {
          
          WHEN BEFORE_INSERT  { 
         //   AccountTriggerBeforeHandler.beforeInsertHandler( Trigger.new );
     
   // While user creating an account if user provides Billing adress 
   //   but not Shipping adress, 
   //write a logic to populate shipping address with billing adress
              for(Account acc : trigger.new){
                  if(     acc.ShippingCity == null  &&  acc.BillingCity != null  ) {
                      
                     acc.ShippingCity  = acc.BillingCity ; 
                  } 
                  
              }  
              
   // When we create the Account record, the Account Owner will be automatically added to Sales Rep field.
   //  When we update the Account owner of the record, then also the Sales Rep will be automatically updated.
           
              Set<Id> setOfAccOwnerIds = new Set<Id>();
              
              for(Account acc : trigger.new){
                  
                 setOfAccOwnerIds.add( acc.OwnerId   );                    
              }
              
              List<user> AccOwnerUser =  [SELECT  id ,name FROM user WHERE id IN: setOfAccOwnerIds] ; 
              
              Map <Id,User> userMap = new Map<Id,User>(AccOwnerUser) ;
           //   Map <Id,User> userMap = new Map<Id,User>([SELECT  id ,name FROM user WHERE id IN: setOfAccOwnerIds]) ;
              
              for(Account acc: trigger.new){
                     
                  user recordSahibi= userMap.get(acc.OwnerId);
                  acc.Sales_Repr__c = recordSahibi.Name ;
                  
                /*
                  for( User sr :AccOwnerUser ) {
                      if( acc.OwnerId == sr.id   )  {
                          
                        acc.Sales_Repr__c = sr.Name ;  
                      }
                   }
               */
               
              }
              
              
              
          }
          WHEN BEFORE_UPDATE  {
      
            AccountTriggerBeforeHandler.beforeUpdateHandler( Trigger.new );
              
         /* 
              for( Account yeniAcc : trigger.new){
                Account eskiAcc = trigger.oldMap.get(yeniAcc.Id);
               
                  if(  eskiAcc.Phone  != yeniAcc.Phone   ){ //  recordun phone fieldi update edilmistir
                      
                      yeniAcc.eski_telefonlar__c =  eskiAcc.eski_telefonlar__c +' , ' +     eskiAcc.Phone;
                   //   acc.Old_Phone__c = acc.Old_Phone__c + '; ' + oldAcc.Phone
                      
                  }
         
              }
          */
                   // List<Id> accIds = new List<Id>();
          Set<Id> accIds = new Set<Id>();
          
          for (Account yeniAcc :Trigger.new){
          //Account eskiHal =Trigger.oldMap.get(yeniAcc .Id);
                 if (yeniAcc .BillingCity != Trigger.oldMap.get(yeniAcc.Id).BillingCity){
                          accIds.add(yeniAcc .Id);
                 } 
          }
          
          List<Contact> conList = [SELECT  id, MailingCity , Account.BillingCity FROM Contact WHERE AccountId IN :accIds];
          
          For(Contact con:conList){
                    con.MailingCity = con.Account.BillingCity;
          }
          Database.update(conList);
        
        // When we create the Account record, the Account Owner will be automatically added to Sales Rep field.
   //  When we update the Account owner of the record, then also the Sales Rep will be automatically updated.      
              
              
              
              
              
              
          
           Set<Id> setOfAccOwnerIds = new Set<Id>();
              
              for(Account acc : trigger.new){
                  Account oldAcc = Trigger.oldMap.get(acc.Id);
                  if(acc.OwnerId !=  oldAcc.OwnerId) {  
                    setOfAccOwnerIds.add( acc.OwnerId   );  
                  }
                                   
              }
              
              List<user> AccOwnerUser =  [SELECT  id ,name FROM user WHERE id IN: setOfAccOwnerIds] ; 
              
              if( AccOwnerUser.size() >0   ){
                  Map <Id,User> userMap = new Map<Id,User>(AccOwnerUser) ;
               //   Map <Id,User> userMap = new Map<Id,User>([SELECT  id ,name FROM user WHERE id IN: setOfAccOwnerIds]) ;
                  
                  for(Account acc: trigger.new){
                         
                      user recordSahibi= userMap.get(acc.OwnerId);
                      acc.Sales_Repr__c = recordSahibi.Name ;
                      
                    /*
                      for( User sr :AccOwnerUser ) {
                          if( acc.OwnerId == sr.id   )  {
                              
                            acc.Sales_Repr__c = sr.Name ;  
                          }
                       }
                   */
                   
                  } 
              }
          }
          WHEN BEFORE_DELETE  { }
          WHEN AFTER_INSERT   {
      /*
       List<Contact> cntList = new List<Contact>();
              for(Account acc: accList){
                    
               contact cnt = new Contact();
                  cnt.FirstName = acc.Name;
                  cnt.LastName = 'AAAAAAAA bu da kontact';
                  cnt.AccountId= acc.id;
                 cntList.add(cnt);
              }
              
               insert cntList;         
      } 
       */
  // yukardaki kodu  BEST practice gostermek icin       AccountTriggerAfterHandler.afterInsertHandler  icine ginderdik       
              
         AccountTriggerAfterHandler.afterInsertHandler( Trigger.new );
          }
          WHEN AFTER_UPDATE   { }
          WHEN AFTER_DELETE   { }
          WHEN AFTER_UNDELETE {
          
          List<Contact> cntList = [SELECT Id, AccountId, Description FROM Contact  WHERE AccountId IN:Trigger.newMap.keySet()]; 
          
          For(Contact cnt : cntList ) {
          Cnt.Description = 'Account restored by ' + System.UserInfo.getName() + ' , on  ' + system.today();
           }
          Database.update(cntList );
  
          
          }
   
      }
    
         
    /*  
      if ( Trigger.isBefore  &&  Trigger.isInsert )  {
          
          for(Account acc: trigger.new){
             acc.Rating = 'Hot';
             acc.BillingState = 'ARKANSAS';
       
          }
          system.debug('Trigger.size===>'+ Trigger.size);
      } 
  
       
       if ( Trigger.isAFTER  &&  Trigger.isInsert )  {
          
           List<Contact> cntList = new List<Contact>();
          for(Account acc: trigger.new){
         
              
           contact cnt = new Contact();
              cnt.FirstName = acc.Name;
              cnt.LastName = 'AAAAAAAA bu da kontact';
              cnt.AccountId= acc.id;
             cntList.add(cnt);
          }
           system.debug('Trigger.size===>'+ Trigger.size);
           insert cntList;
      } 
  
      
      */
      
      
      /*
            system.debug('KAC DEFA CALISTI'); 
            system.debug('Trigger.size ===>> ' + Trigger.size  );
      */
    /*  
      system.debug('KAC DEFA CALISTI');
      system.debug('Trigger.isBefore==>' + Trigger.isBefore);
      system.debug('Trigger.isAfter==>'  + Trigger.isAfter);
      system.debug('Trigger.isInsert==>' + Trigger.isInsert); 
      system.debug('Trigger.isUpdate==>' + Trigger.isUpdate);
      
      system.debug('Trigger.operationType ==>' + Trigger.operationType); 
       
  */    
  }