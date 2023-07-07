public class LeadTriggerBeforeHandler {

    public static void beforeInsertHandler( List<Lead> leadList   ){

        //    When a new Lead is created assign ‘Education’  if Industry field is null 
    for(Lead leadfromList : leadList ){

          if( leadfromList.Industry == null) {
                leadfromList.Industry = 'Education'; 
             }
      }
     
 }
 
 
 public static void beforeUpdateHandler( List<Lead> leadList  ){
   
     //   if Lead is updated, assign ‘Banking’ if Industry field is null

          for(Lead leadfromList : leadList){

          if( leadfromList.Industry == null) {
                leadfromList.Industry = 'Banking'; 
             }
      }  
   
 }
 
 
 public static void beforeDeleteHandler (){
     
     
 } 
 
 
 
}