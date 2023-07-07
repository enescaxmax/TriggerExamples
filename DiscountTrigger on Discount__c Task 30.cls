trigger DiscountTrigger on Discount__c (before insert , before update) {
    
    SWITCH on Trigger.operationType {
        WHEN BEFORE_INSERT { 
            
            Set<Id> oppIds= new Set<id>();
            for(Discount__c dst :  trigger.new){
                oppIds.add(dst.Opportunity__c);
            }
            
            //   List<Opportunity> oppList = [SELECT id, amount FROM opportunity WHERE id IN:oppIds ]; 
            
            map<ID, Opportunity> mapOpp = new Map<ID , Opportunity>([SELECT id, amount FROM opportunity WHERE id IN:oppIds ]);
            
            
            for(Discount__c dst : trigger.new){
                
                Boolean isAmountNull = mapOpp.get(dst.Opportunity__c).amount != null;
                
                if( dst.Discount_Type__c != null && String.isNotBlank(dst.Discount_Type__c) &&  dst.Discount_Amount__c != null && isAmountNull  ){
                    
                    if(dst.Discount_Type__c == 'Raw Amount' ){
                        
                        dst.Net_Discount__c = dst.Discount_Amount__c ;
                    }else {
                        //   for( Opportunity opp : oppList ){    
                        
                        //  if ( dst.Opportunity__c == opp.id ) {   
                        
                        dst.Net_Discount__c = mapOpp.get(dst.Opportunity__c).amount * ( dst.Discount_Amount__c /100 ); 
                        
                        //  }
                        //  }
                    }
                }   
            }
        }
        WHEN BEFORE_UPDATE { 
            
            Set<Id> oppIds= new Set<id>();
            for(Discount__c dst :  trigger.new){
                oppIds.add(dst.Opportunity__c);
            }
            
            //   List<Opportunity> oppList = [SELECT id, amount FROM opportunity WHERE id IN:oppIds ]; 
            
            map<ID, Opportunity> mapOpp = new Map<ID , Opportunity>([SELECT id, amount FROM opportunity WHERE id IN:oppIds ]);
            
            
            for(Discount__c dst : trigger.new){
                
                Discount__c oldVer = trigger.oldMap.get(dst.id);
                
                if (  ( dst.Discount_Amount__c != oldVer.Discount_Amount__c  ||  dst.Discount_Type__c !=  oldVer.Discount_Type__c) ) {
                    
                    
                    
                }
                
                Boolean isAmountNull = mapOpp.get(dst.Opportunity__c).amount != null;
                if( dst.Discount_Type__c != null && String.isNotBlank(dst.Discount_Type__c) &&  dst.Discount_Amount__c != null && isAmountNull     ){
                    if (  ( dst.Discount_Amount__c != oldVer.Discount_Amount__c  ||  dst.Discount_Type__c !=  oldVer.Discount_Type__c) ) {
                        
                        if(dst.Discount_Type__c == 'Raw Amount' ){
                            
                            dst.Net_Discount__c = dst.Discount_Amount__c ;
                        }else {
                       
                            dst.Net_Discount__c = mapOpp.get(dst.Opportunity__c).amount * ( dst.Discount_Amount__c /100 ); 
      
                        }
                    } 
                }
            }
            
            
            
        }
        WHEN BEFORE_DELETE { }
        WHEN AFTER_INSERT  { }
        WHEN AFTER_UPDATE  {  }
        WHEN AFTER_DELETE  { }
        WHEN AFTER_UNDELETE { }
    }
    
    
    
    
}