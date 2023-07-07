public class AccountTriggerBeforeHandler {

    public static void beforeInsertHandler( List<account> accList  ){
  /* If an account is created 
      No matter what The rating of account should be ‘Hot’
      and BillingState should be ‘ARKANSAS’ 
  */
    
           for(Account acc: accList){
               
           acc.Rating = 'Hot';
           acc.BillingState = 'ARKANSAS';
               
    // Before creating an Account if the industry filed is null assign ‘Banking’ to Industry field 
               if(acc.Industry == null   ) {   // String.isBlank(acc.Industry) 
                       acc.Industry = 'Banking';
                } 
          }
    
    }
    
    
    
      public static void beforeUpdateHandler( List<account> accList   ){
        
          // Before updating an Account assign ‘Education’ to Industry field if the fiedl is null

           for( Account acc: accList){
                if(acc.Industry == null   ) {   // String.isBlank(acc.Industry) 
                    
                    acc.Industry = 'Education';
                } 
            } 
        
    }
    
  
    public static void beforeDeleteHandler(){
        
        
        
    }
}