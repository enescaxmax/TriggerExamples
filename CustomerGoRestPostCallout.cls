public class CustomerGoRestPostCallout {

    // POSt request
  // https://gorest.co.in/public/v2/users?name=resul&status=active&email=email@dsfsaf.com&gender=male 
   
   // https://gorest.co.in/public/v2/users    // we send record in body of JSON
   
   Private static FINAL string END_POINT = 'https://gorest.co.in/public/v2/users';
  
  // first option   sending the data with URL 
   
   public static Void postRecordToGoRestWithUrl(string stName , string stEmail , string stStatus , string stGender){
 
        Http http = new Http();  
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint(END_POINT+ '?name=' + stName +'&email=' + stEmail +'&status=' + stStatus +'&gender=' + stGender );
                 // https://gorest.co.in/public/v2/users?name=resul&status=active&email=email@dsfsaf.com&gender=male 
       
       request.setHeader('Authorization', 'Bearer d76e2755ffe26232f550bd5920e3620a537c9252f0333ae7dfa7755750ae3ef9');
       request.setHeader('Content-Type', 'application/json; charset=utf-8');
       
       
       HttpResponse response =  http.send(request);
       
       if ( response.getStatusCode() == 201){
           
     system.debug(' congrats  you have created a record!!');            
       }else {
           
        system.debug(' Huston  we have a problem !! ' +  response.getStatusCode());     
           
       }
   }  
   

 //  second option  we want to send data on body of JSON 
   public static Void postRecordToGoRestWithBody(){
 
        Http http = new Http();  
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint(END_POINT );
                 // https://gorest.co.in/public/v2/users    // we send record in body of JSON
       
       request.setHeader('Authorization', 'Bearer d76e2755ffe26232f550bd5920e3620a537c9252f0333ae7dfa7755750ae3ef9');
       request.setHeader('Content-Type', 'application/json; charset=utf-8');
       
       String bodyOfRequest ='{ "name": "created by Body", "email": "hsnfgdgdsg56@rt.ca","gender": "female","status": "active"}';
            
       /*
        {         
           "name": "Resul New",
           "email": "newemail@asdkfjaskdf.ca",
           "gender": "male",
           "status": "active"
        }
       
     */
     request.setBody(bodyOfRequest);
       
       HttpResponse response =  http.send(request);
       
       if ( response.getStatusCode() == 201){
           
     system.debug(' congrats  you have created a record!!');            
       }else {
           
        system.debug(' Huston  we have a problem !! ' +  response.getStatusCode());     
           
       }
   }  
   
   
   //  second option  we want to send ** RECORD FROM SF DATABASE *** on body of JSON  ****  WITH TRIGGER *** 
   public static Void postSFRecordToGoRestWithTrigger( String studentId){
 
        Http http = new Http();  
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint(END_POINT );
                 // https://gorest.co.in/public/v2/users    // we send record in body of JSON
       
       request.setHeader('Authorization', 'Bearer d76e2755ffe26232f550bd5920e3620a537c9252f0333ae7dfa7755750ae3ef9');
       request.setHeader('Content-Type', 'application/json; charset=utf-8');
       
       //  retrive a student record from SF database 
       student__c selectedSt= [ SELECt id ,status__c , email__c , name  FROM student__c WHERE id =: studentId     ]; 
       
       // creatinf a contaoiner record to serialze
       CustomerContainer stToPost = new CustomerContainer();
        // MAPINg the retrieved record with container      
           stToPost.name= selectedSt.name;
           stToPost.email = selectedSt.email__c;
           stToPost.gender = 'male';
           stToPost.status = selectedSt.status__c;
       // serializing the contaner record
       String bodyOfRequest = JSON.serialize(stToPost);
            
    
     request.setBody(bodyOfRequest);
       
       HttpResponse response =  http.send(request);
       
       if ( response.getStatusCode() == 201){
           
     system.debug(' congrats  you have created a record!!');            
       }else {
           
        system.debug(' Huston  we have a problem !! ' +  response.getStatusCode());     
           
       }
   }  
}