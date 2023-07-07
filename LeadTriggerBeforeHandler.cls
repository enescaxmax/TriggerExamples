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
    
    
    
    
    
    
}