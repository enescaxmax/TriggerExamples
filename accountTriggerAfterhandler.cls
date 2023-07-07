public class AccountTriggerAfterHandler {

    
    public static void afterInsertHandler( List<Account> accList ){
   /* 
     If an account is created Create a contact related to newly created account
    
   */
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
    
    
}