public class AccountTriggerBeforeHandler {

    
    public static void beforeInsertHandler( List<Account> accList     ){
        for(Account accfromList : accList ){
   /**If an account is created 
        No matter what The rating of account should be ‘Hot’
        and BillingState should be ‘ARKANSAS’
     */          
            
             accfromList.Rating = 'Hot';
             accfromList.BillingState = 'ARKANSAS';
  /*
Before creating an Account if the industry filed is null assign ‘Banking’ to Industry field
bb*/
             if( accfromList.Industry == null) {
                   accfromList.Industry = 'Banking'; 
                }
         }
        
    }
    
    
    public static void beforeUpdateHandler( List<Account> accList   ){
        
 /*      
        Before updating an Account assign ‘Education’ to Industry field if industry field is null

    */
       for(Account accfromList : accList){

             if( accfromList.Industry == null) {
                   accfromList.Industry = 'Education'; 
                }
         }        
    }
    
    
    public static void beforeDeleteHandler (){
        
        
    }
    
}