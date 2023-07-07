
//########################################### trigger ile goRest musteri gonderme.################################################

trigger musteriTrigger on musteri__c (after insert , after update) {

    SWITCH on Trigger.operationType {
        WHEN BEFORE_INSERT  { }
        WHEN BEFORE_UPDATE  { }
        WHEN BEFORE_DELETE  { }
        WHEN AFTER_INSERT   {
        
         for(musteri__c mst : trigger.new ) {
                
                musteri__c eskiMst = Trigger.oldMap.get(mst.Id);
                
                if(  mst.goRestGonder__c  &&   eskiMst.goRestGonder__c == false   ) { 
                    
                      MusteriGoRestPostCallout.musteriPostIdKaydet( mst.id); 
                }
            }
        
        }
        WHEN AFTER_UPDATE   { 
        
            for(musteri__c mst : trigger.new ) {
                
                musteri__c eskiMst = Trigger.oldMap.get(mst.Id);
                
                if(  mst.goRestGonder__c  &&   eskiMst.goRestGonder__c == false   ) { 
                    
                      MusteriGoRestPostCallout.musteriPostIdKaydet( mst.id); 
                }    
            }    
        }
        WHEN AFTER_DELETE   { }
        WHEN AFTER_UNDELETE { }
 }
    



//  triggerdan cagirilacak method
 
      @future(callout=true)
    public static void musteriPostIdKaydet(ID musteriId){
        
       
        Http http = new Http();  //  yeni http olustruduk
      
        HttpRequest request = new HttpRequest();   // yeni request olusturduk
        
        request.setMethod('POST');   // karsi database record eklemek icin methodumuz  POST olmak zorundadir
        request.setEndpoint(END_POINT);
                             // https://gorest.co.in/public/v2/users/    ?name=   Resul yeni   &email=   dsfsafsad@dfsaf  &status=active&gender=male
        
        //  asagidaki iki satir go rest icin gerekli olan Authorization yapilmasi icin yazildi 
         request.setHeader('Authorization', 'Bearer d76e2755ffe26232f550bd5920e3620a537c9252f0333ae7dfa7755750ae3ef9'); 
         request.setHeader('Content-Type', 'application/json; charset=utf-8');
     
         musteri__c secilenMusteri = [ SELECT ID , name ,status__c , email__c  FROM musteri__c WHERE ID =:musteriId ];
         
         musteriContainer gidecek = new musteriContainer();
         gidecek.name = secilenMusteri.name;
         gidecek.email= secilenMusteri.email__c;
         gidecek.gender = 'male';
         gidecek.status= secilenMusteri.status__c;
         
         
         String json = JSON.serialize(gidecek);
         request.setBody(json);
        
        HttpResponse response = http.send(request);   // requestimizi gonderdik ve gelen kismi response icine kaydeddik.
        
      
       
        if( response.getStatusCode() == 201 ){
       
           // String jsonBody = response.getBody();   //  gelen response icindeki bodyi json formationda kaydettik
         
            system.debug(' karsiya kayit oldu');
            
            
        }else{
            System.debug(' kodda hata var kardes  bir incele' + response.getStatusCode() );
        }
    } 
    
}
    
    
}
