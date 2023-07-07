public class LeadTriggerHandler {

    public static void industryFieldCheck (List<Lead> leadList  ){
        
       // If a new Lead is created or updated and if ‘Industry’ filed is null; Give a warning           
            for(Lead armut : leadList) {
                
                if( armut.Industry == null) {
                 //    armut.addError('Industry field bos birakilamaz !!!');    // sayfa uzerinde hata verdirmek icin
                    armut.Industry.addError('Industry field bos birakilamaz !!!'); 
                
                }
                
                
            }       
        
    }  

    
    // Create an error (Warning) trigger when a Lead is updated from 'Open - Not Contacted' 
 // status to 'Closed - Converted' or 'Closed - Not Converted' status. (Validation )
    public static void statusCheck (List<lead> leadList , Map<ID ,Lead> leadOldMap ){
        
              
            for( Lead yeniLead : leadList ){
    
                
                    Lead eskiLead = leadOldMap.get(yeniLead.Id);
                
                    if ( eskiLead.status == 'Open - Not Contacted' && ( yeniLead.Status == 'Closed - Converted' || yeniLead.Status == 'Closed - Not Converted'    )  ){
                        
                        yeniLead.addError('kardes hele bir once telefon edip lead ile gorussen mi sonra convert edersin !!!'); 
                    }
                  
                    
            }
    }




    
    public static Boolean armut= true;
    
    public static void reqursionEngelleme(List<Lead> yeniListe){
       // Generate a trigger that After creating a new lead, 
  // Creates another lead ( FirstName = ‘AAA new Lead Created’ )
      
        if(armut ){
            
            armut = false;
           List<Lead> leadList = new List<lead>();  
            for(Lead elma : yeniListe) {
             
                Lead yeniLead = new Lead();
                yeniLead.FirstName = 'AAA new Lead Created';
                yeniLead.LastName = 'AAA te=rigger Lead';
                yeniLead.Company = 'Wise ';
                yeniLead.Industry = 'Banking';
                
                leadList.add(yeniLead);
              
            }
            database.insert(leadList);
 
            
        } 
        
                   
        
        
    }
    
    
    
    
}