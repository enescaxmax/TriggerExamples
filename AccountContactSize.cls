public class AccountContactSize {

    
    public static INTEGER getNumOfContacts ( Id contactsAccountId    ){
        List<Contact> accountContacts = [SELECT Id FROM Contact WHERE AccountId = :contactsAccountId]; 
      
        return accountContacts.size();
    } 
    
    
}





//  option first

@isTest
public class AccountContactSizeTest {

    
    // try not to use  (SeeAllData = true)   try not to rach to your SF database
   @isTest(SeeAllData = true) 
    static void getNumOfContactsTest(){
   // checking the number of contacts  
   
        Account acc = [SELECT id FROM account where name='United Oil & Gas, Singapore'];
   
        INTEGER cntSize   =    AccountContactSize.getNumOfContacts ( acc.id  );
        
     // positive senario 
       system.assertEquals(2, cntSize);
        
        // negative senario
        system.assertNotEquals(1, cntSize);
    }
    
   
}


//  option second



@isTest
public class AccountContactSizeTest2 {

     // second option
   @isTest
    static void getNumOfContactsTest(){
   // checking the number of contacts  
    Account acc = new Account();
        acc.Name = 'test';
        insert acc;
        
     Contact cnt = new Contact();
        cnt.LastName = 'whatever';
        cnt.AccountId = acc.id;
      insert cnt;
        
        INTEGER cntSize   =    AccountContactSize.getNumOfContacts ( acc.id  );
        
     // positive senario  // SECOND CONTACT IS CREATED BY ACCOUNT TRIGGER
       system.assertEquals(2, cntSize);
        
        // negative senario
        system.assertNotEquals(3, cntSize);
    }

    
}