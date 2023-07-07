public class AccountTriggerAfterHandler {

    
    public static void afterInsertHandler( List<account> accList ){
       
        List<Contact> cntList = new List<Contact>(); 
         for(Account accfromList : accList){
                          
              Contact cnt = new Contact();
              cnt.LastName = 'AA AFTER INSERT';
              cnt.AccountId = accfromList.id;
              cntList.add(cnt);
        }
         insert cntList;
        
    }
    
     public static void afterUpdateHandler( ){
        
        
    }
    
     public static void afterDeleteHandler( ){
        
        
    }
    
     public static void afterUndeleteHandler( ){
        
        
    }
}