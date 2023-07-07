trigger OpportunityTrigger on Opportunity (  after update) {
    
    SWITCH on Trigger.operationType {
        WHEN BEFORE_INSERT { }
        WHEN BEFORE_UPDATE { }
        WHEN BEFORE_DELETE { }
        WHEN AFTER_INSERT  { }
        WHEN AFTER_UPDATE  { 
            // Our room division manager wants to see the total number of each guest’s closed won opportunities
            //  which are the individual visit type on the guest layout
            SET<ID> oppId= new SET<Id>();
            List<Id> guestIds = new List<Id>();
            
            /*       
RecordType individualRecordType = [SELECT Id, developerName, SobjectType FROM RecordType WHERE SobjectType = 'Opportunity' AND developerName = 'Individual_guest']; 
ID recTypeId = individualRecordType.id;
*/   
            try{
            String recType = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Individual_Guest').getRecordTypeId();
            
            //   first step  to retrive OPP ids        
            for(Opportunity opp : Trigger.new){
                //  to find individual record type   
                Opportunity oldVer = Trigger.oldMap.get(opp.Id);
                if( opp.IsWon && (opp.StageName != oldVer.StageName  ) &&   opp.RecordTypeId == recType)  
                    oppId.add(opp.id);
                
            }
            
            // second step  to retrive Guest Ids  I need to query Opp Guest Intermediate        
            
            if ( oppId.size()> 0 && oppId != null ) {
                List<Opp_Guest_Intermediate__c>  intermediateList = [SELECT  id,guest__c  FROM Opp_Guest_Intermediate__c WHERE Opportunity__c IN: oppId] ; 
                
               
                for( Opp_Guest_Intermediate__c inter : intermediateList  ){
                   
                    guestIds.add(inter.Guest__c);
                } 
            }     
            
            // third step  to increment the number on Number_of_Closed_won_opportunities__c field ON GUEST obj
            
            // query the guests records 
           List<guest__c >  guestRecords = [SELECT id , Number_of_Closed_won_opportunities__c FROM guest__c WHERE id IN: guestIds ];
            
            for( Guest__c gst : guestRecords ) {
               
               gst.Number_of_Closed_won_opportunities__c = gst.Number_of_Closed_won_opportunities__c + 1;
            }
            
            update guestRecords;
                
            } catch(Exception e){ System.debug(' you have a problem >>> :'  + e.getMessage());   }
        }
        WHEN AFTER_DELETE  { }
        WHEN AFTER_UNDELETE { }
    }
    
}