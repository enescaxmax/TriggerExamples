trigger HastaTrigger on Hasta__c (before insert , before update , before delete , after insert , after update, after delete, after undelete) {

    
    SWITCH on Trigger.operationType {
        
        WHEN BEFORE_INSERT  { }
        WHEN BEFORE_UPDATE  { }
        WHEN BEFORE_DELETE  {}
        WHEN AFTER_INSERT   {
            
          List< Hasta__share > yaniSharingList = new List<Hasta__share>(); 
            
            
            for(Hasta__c hasta : Trigger.new){
             
               Hasta__share yeniPaylasim = new Hasta__Share();
                yeniPaylasim.ParentId      = hasta.Id;
                yeniPaylasim.UserOrGroupId = hasta.Hemsire__c;
             // yeniPaylasim.UserOrGroupId = hasta.Doctor__c ;
                yeniPaylasim.AccessLevel   = 'Edit';
                yeniPaylasim.RowCause      = 'Manual';
                
                yaniSharingList.add(yeniPaylasim);
               
            }
            database.insert(yaniSharingList); 
            
        }
        WHEN AFTER_UPDATE   {}
        WHEN AFTER_DELETE   { }
        WHEN AFTER_UNDELETE { }
 
    }
}