trigger AYeniHastaTrigger on AYeniHasta__c (before insert , before update , before delete , after insert , after update, after delete, after undelete) {
    
    SWITCH on Trigger.operationType {
     // sadece after INSERT icin yazdik   
        WHEN AFTER_INSERT   {
        
             List<AYeniHasta__Share> paylasList = new List<AYeniHasta__Share>();
                           
             for(AYeniHasta__c hasta:trigger.new){
                          
             AYeniHasta__Share paylas1 = AYeniHastaTriggerHandler.paylasmaRecordOlustur(hasta.Id,hasta.Doktor__c);
             AYeniHasta__Share paylas2 = AYeniHastaTriggerHandler.paylasmaRecordOlustur(hasta.Id,hasta.Hemsire__c);
                              
             paylasList.add(paylas1);
             paylasList.add(paylas2);
                        
               }
                           
             Database.insert(paylasList);


       //hemsire UPDATE edildiginde sharing degismesi icin hazirlandi                         }
        WHEN AFTER_UPDATE {
                // EGER  hemsire degisirse
            List<ID> HemsireIcinHastaIdleri = new List<ID>();
            List<Id> hemsireId= new List<ID>();
   
            for(AYeniHasta__c hasta:trigger.new){
                       
                       if( (hasta.hemsire__c != trigger.oldMap.get(hasta.id).Hemsire__c)   ){
                          HemsireIcinHastaIdleri.add(hasta.id); 
       // bize hastanin eski hemsiresinin id si lamzim ki biz asagidaki query de dogru recordu getirelim
                          hemsireId.add(trigger.oldMap.get(hasta.id).Hemsire__c);
                       }
              }               
            
            
            if(HemsireIcinHastaIdleri.size()>0){
   //  WHERE parentId IN:HemsireIcinHastaIdleri AND UserOrGroupId IN:hemsireId    iki degeri birden kontrol etmek zorundayiz 
   //  zira sadece birini kontrol etsek
   //  ayni hasta icin 
   //  hem doktor hem hemsire icin ayri kayit bulunuyor  bu sefer doktorun kaydi silinirdi
       List<AYeniHasta__Share> guncellenecekListeHemsireIcin = [ SELECT id, parentId,UserOrGroupId FROM AYeniHasta__Share WHERE parentId IN:HemsireIcinHastaIdleri AND UserOrGroupId IN:hemsireId ];  //AND UserOrGroupId IN:hemsireId 
         
          // ******ayeniHAsta__share recordlarinda eski record silinmeden UserOrGroupId field guncellenemiyor   KURAL BU*****
             Database.delete(guncellenecekListeHemsireIcin);
    
          // eski recordlar silindikten sonra yeni record yerine yerlestiriliyor     
           
                List<AYeniHasta__Share> yeniListe = new List <AYeniHasta__Share>();            
            for(AYeniHasta__c hasta:trigger.new){
                for(AYeniHasta__Share guncelle : guncellenecekListeHemsireIcin){
 //  burada tekrar eski hemsire ve yeni hemsirenin farkli oldugunu ikinci defa kontrol ettik  gerke de olmayabilirdi
                   if( (hasta.hemsire__c != trigger.oldMap.get(hasta.id).Hemsire__c)   ){
                     
                       AYeniHasta__Share paylas1=   AYeniHastaTriggerHandler.paylasmaRecordOlustur(guncelle.parentId ,hasta.Hemsire__c); 
                       yeniListe.add(paylas1);
                       
                       }
               
                   } 
            }
         
           database.insert(yeniListe);
             } 
       }
      
    }
       
       
    }
     



public class AYeniHastaTriggerHandler {
    
    
    public static   AYeniHasta__Share   paylasmaRecordOlustur(ID hastaninIdsi ,ID paylasilacakKisi) {
        
        AYeniHasta__Share  paylas = new AYeniHasta__Share();
        paylas.ParentId= hastaninIdsi;
        paylas.UserOrGroupId = paylasilacakKisi;
        paylas.AccessLevel = 'edit';
        paylas.RowCause = 'manual';
        
        return paylas;
        
        
    }
    

}