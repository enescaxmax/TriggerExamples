trigger AccountTrigger on Account (before insert , before update , before delete , after insert , after update, after delete, after undelete ) {

    SWITCH on Trigger.operationType {
          
        WHEN BEFORE_INSERT { 
        
            for( Account acc : trigger.new){
                acc.name = acc.name + ' INSERTED';
            }
        
        }
        WHEN BEFORE_UPDATE { 
        
             for( Account acc : trigger.new){
                acc.name = acc.name + ' UPDATED';
            }
        }
        
        //  WHEN AFTER_INSERT   {  AccountTriggerAfterHandler.afterInsertHandler(Trigger.new ); }
   
      }
    
         
    
  }
  
  
  
  
  
  
  
  ///********  tets class ****** // 
  
  @isTest
  public class AccountTriggerTest {
  
      //  account insert edildiginde calisan triggerin before insert kismi test ediliyor
      @isTest
      static void accountBeforeInsertTest(){
         Account acc = DataFactory.createAccount();
          acc.Name= 'armut';
          insert acc;
          
          Account yeniAcc= [SELECT id,name FROM account where id=:acc.id];
          
          system.assertEquals('armut INSERTED', yeniAcc.name); 
          system.assertNotEquals('armut', yeniAcc.name);
      }
      
     
      
      @isTest
      static void accountBeforeUpdateTest(){
         Account acc = DataFactory.createAccount();
          acc.Name= 'armut';
          insert acc;
          
          Account yeniAcc= [SELECT id,name FROM account where id=:acc.id];
          yeniAcc.Name = 'degisti';
          update yeniAcc;
          
          Account sonAcc= [SELECT id,name FROM account where id=:acc.id];
          
          system.assertEquals('degisti UPDATED', sonAcc.name); 
     
      }
      
      
  }