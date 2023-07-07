trigger RoomAvailabilityCheck on OpportunityLineItem (before insert , before update) {

    List<OpportunityLineItem> allOppLineItemRecords = [SELECT Id, OpportunityId, Product2Id , 
                                                       Opportunity.Check_In_Date__c, Opportunity.Planned_Check_Out_Date__c ,Opportunity.Actual_Check_Out_Date__c,
                                                       Product2.Room_Number__c
                                                       FROM OpportunityLineItem
                                                      WHERE NOT  Opportunity.Planned_Check_Out_Date__c < TODAY ];
    
    
    
   set<id> oppIds = new set<id>();
    
    for(OpportunityLineItem oppLine : allOppLineItemRecords ){
        
        oppIds.add(oppLine.OpportunityId);
        
    }
    
    for(OpportunityLineItem oppLine: trigger.new ){
        oppIds.add(oppLine.OpportunityId);
        
    }
    
    
   Map<id,Opportunity> oldOpp = new  Map<id,Opportunity>([ SELECT Id, Check_In_Date__c, Planned_Check_Out_Date__c, Actual_Check_Out_Date__c 
                                                          FROM Opportunity 
                                                          WHERE id IN : oppIds]);
    
    DateTime newCheckIn;
    DateTime newCheckOut;
    DateTime oldCheckIn;
    DateTime oldCheckOut;
    
    
    
    
    for( OpportunityLineItem  OLDOppLineItem :  allOppLineItemRecords){
        
        for( OpportunityLineItem  NEWOppLineItem : trigger.new  ){
            
            if( OLDOppLineItem.Product2Id ==  NEWOppLineItem.Product2Id ) {
          
                oldCheckIn = OLDOppLineItem.Opportunity.Check_In_Date__c;
                system.debug('oldCheckIn ' + oldCheckIn);
                if( OLDOppLineItem.Opportunity.Actual_Check_Out_Date__c != null ) {
                    
                    oldCheckOut =OLDOppLineItem.Opportunity.Actual_Check_Out_Date__c;
                   system.debug('oldCheckOut ' + oldCheckOut);
                }else {
                    oldCheckOut = OLDOppLineItem.Opportunity.Planned_Check_Out_Date__c;
                     system.debug('oldCheckOut ' + oldCheckOut);
                } 
                
           
            /*    
             newCheckIn= NEWOppLineItem.Opportunity.Check_In_Date__c;  
                system.debug('newCheckIn ' + newCheckIn);
                
             newCheckOut= NEWOppLineItem.Opportunity.Planned_Check_Out_Date__c;
                system.debug('newCheckOut ' + newCheckIn);
              */
               newCheckIn=   oldOpp.get( NEWOppLineItem.OpportunityId).Check_In_Date__c;  
                system.debug('newCheckIn ' + newCheckIn);
                
             newCheckOut= oldOpp.get( NEWOppLineItem.OpportunityId).Planned_Check_Out_Date__c;
                system.debug('newCheckOut ' + newCheckOut);
                
                
                
                
            
               if ( newCheckIn < oldCheckOut   &&  newCheckOut  >  oldCheckIn ) {
                   
                   
                  NEWOppLineItem.addError ('The room you want to book is occupied between the dates you want. Please select another room  ');  
                   
               }
                
                
                
            }
            
            
        }
        
        
        
        
    }
    
    
}