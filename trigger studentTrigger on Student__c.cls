trigger studentTrigger on Student__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
SWITCH on Trigger.operationType {
   WHEN BEFORE_INSERT{
        }
   WHEN BEFORE_UPDATE{
    	
       }
   WHEN BEFORE_DELETE{
         }
    WHEN AFTER_INSERT{
        List<Report_Card__c> repcarlist= new list<Report_Card__c>();
        For( Student__c std: Trigger.new){
            Report_Card__c newRepCard= new Report_Card__c();
            newRepCard.Student__c= std.Id;
            newRepCard.Academic_Term__c='2023-2';
            repcarlist.add(newRepCard);
        }database.insert(repcarlist);//database.insert(repcarlist);
        system.debug(repcarlist);
    }
    WHEN AFTER_UPDATE{}
    WHEN AFTER_DELETE{}
    WHEN AFTER_UNDELETE{}
                }}