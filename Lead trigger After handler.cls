public class LeadTriggerAfterHandler {

    
    public static Boolean  flag = true;
    
    public static void recursionExample(List<lead> leadList ){
       
        if( flag ){
          
            flag = false;
            
                   List<lead> leadListToCreate = new List<lead>();
            for(Lead newLead : leadList){
              Lead newlyCreatedLead = new Lead(); 
                newlyCreatedLead.LastName = 'Recursion';
                newlyCreatedLead.Company = 'Wise';
                newlyCreatedLead.FirstName = 'AAA new Lead Created';
                
               leadListToCreate.add(newlyCreatedLead); 
            //    insert newlyCreatedLead;
                
            }
            database.insert(leadListToCreate);   
            
        }
      
    }
}