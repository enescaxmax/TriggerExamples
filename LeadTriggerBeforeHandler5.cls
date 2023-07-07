public class LeadTriggerBeforeHandler {

    public static void beforeInsertHandler( List<Lead> leadList   ){

        //    When a new Lead is created assign ‘Education’  if Industry field is null 
 /*   for(Lead leadfromList : leadList ){

          if( leadfromList.Industry == null) {
                leadfromList.Industry = 'Education'; 
             }
      }
    */    
        
      // If a new Lead is created or updated and 
  //if ‘Industry’ filed is null; Give a warning      
     for(Lead leadfromList : leadList ){

          if( leadfromList.Industry == null) {
               leadfromList.addError('You have to provide Industry !!! ');
             }
      }      
    
 }
 
 
 public static void beforeUpdateHandler( List<Lead> leadList  ){
   
     //   if Lead is updated, assign ‘Banking’ if Industry field is null

     /*     for(Lead leadfromList : leadList){

          if( leadfromList.Industry == null) {
                leadfromList.Industry = 'Banking'; 
             }
      }  
     */
     // If a new Lead is created or updated and 
  //if ‘Industry’ filed is null; Give a warning      
     for(Lead leadfromList : leadList ){

          if( leadfromList.Industry == null) {
               leadfromList.addError('You have to provide Industry !!! ');
             }
      }    
   
 }
 
 
 public static void beforeDeleteHandler (){
     
     
 } 
 
 
 
}