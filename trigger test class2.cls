trigger AccountTrigger on Account (before insert , before update , before delete , after insert , after update, after delete, after undelete  ) {

   
    
    SWITCH on Trigger.operationType {
        WHEN BEFORE_INSERT{
            for( Account acc : trigger.new){
                
                acc.name = acc.name+ ' INSERTED';
            }
        }
        WHEN BEFORE_UPDATE{
           for( Account acc : trigger.new){
                
                acc.name = acc.name+ ' UPDATED';
            } 
        }
         /*
           WHEN AFTER_INSERT   { 
            AccountTriggerAfterHandler.afterInsertHandler( Trigger.new );
     
           }
        */
          
   }
   }
   
   
   
   
   ///  AccountTriggerTest
   //
   
   @isTest
   public class AccountTriggerTest {
   
       @isTest
       static Void  AccountTriggerBeforeInsertTest (){
           
           Account acc = DataFactory.createAccount();
               acc.name = 'apple';
           insert acc;
           
   //   fire before insert trigger     name will be changed to apple INSERTED  
          Account newAcc= [SELECT id,name FROM account WHERE id=:acc.id];
           
           system.assertEquals('apple INSERTED', newAcc.name);
       }
      
      @isTest
       static Void  AccountTriggerBeforeUpdateTest (){
           
           Account acc = DataFactory.createAccount();
               acc.name = 'apple';
           insert acc;
      
          Account afterInsertAcc= [SELECT id,name FROM account WHERE id=:acc.id];
           afterInsertAcc.name='resul';
           update afterInsertAcc;
           
         Account afterUpdateAcc= [SELECT id,name FROM account WHERE id=:acc.id];  
           system.assertEquals('resul UPDATED', afterUpdateAcc.name);
       } 
       
   }