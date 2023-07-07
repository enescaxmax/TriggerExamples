trigger AccountTrigger on Account (before insert , before update , before delete , after insert , after update, after delete, after undelete ) {

    SWITCH on Trigger.operationType {
          
          WHEN BEFORE_INSERT  { 
              for(Account acc: trigger.new){
             acc.Rating = 'Hot';
             acc.BillingState = 'ARKANSAS';
       
          }
          system.debug('Trigger.size===>'+ Trigger.size); 
                              }
          WHEN BEFORE_UPDATE  { }
          WHEN BEFORE_DELETE  { }
          WHEN AFTER_INSERT   {
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
          WHEN AFTER_UPDATE   { }
          WHEN AFTER_DELETE   { }
          WHEN AFTER_UNDELETE { }
   
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