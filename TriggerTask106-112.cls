/*TASK 106: Bir Account oluşturulduğunda eğer ratingi boş ise ratingini 
'Warm' ;eğer ownershipi public ise ratingini 'Hot' yapalım ve her iki durum için de 
Descriptiona da bu kaydı hangi userın ne zaman oluşturduğunu yazdıralım lütfen.*/
WHEN BEFORE_INSERT {
        
            for(Account acc:Trigger.new){
                if(acc.Rating==null){
                    acc.Rating='Warm';}
                    //acc.Description='This Account is created by 
'+system.UserInfo.getName()+' on '+system.today();
                if(acc.Ownership=='Public'){
                    acc.Rating='Hot';  
                
                }acc.Description='This Account is created by 
'+system.UserInfo.getName()+' on '+system.today();
                }
            }
/*TASK 107:Yeni bir contact oluşturulduğunda contactın mailing address i boş ise 
ilgili  Accountun billing adresi assign edilsin. */
WHEN BEFORE_INSERT {
           Set<Id> accIds=new Set<Id>(); 
            for(Contact cnt: Trigger.new){
                 if(cnt.AccountId!=null){
                     accIds.add(cnt.AccountId); }
            }
            list<Account> accList=[Select id, Name, BillingAddress From Account 
Where id In: accIds];
                       for(Account acc : accList){
                           for(Contact cnt:Trigger.new){
                       if(acc.BillingAddress!=null && cnt.MailingAddress==null){
                       cnt.MailingStreet=acc.BillingStreet;
                       cnt.mailingCity=acc.BillingCity;
                       cnt.MailingPostalCode=acc.BillingPostalCode;
                       cnt.MailingState=acc.BillingState;
                       cnt.MailingCountry=acc.BillingCountry;
                       } }}
                           }
/*TASK 108:Eğer bir Lead in Ratingi Hot ise ve Open iken Closed - Not Converted 
olarak update edilmişse,Lead ownera, manageri ile 3 gün içinde iletişime 
gecmesini sağlayacak sekilde bir task assign edelim. */        
            List<Task> newTasks=new List<Task>();
            for(Lead myLead : Trigger.new){
                Lead oldversionLead=Trigger.oldMap.get(myLead.id);
                if(myLead.Rating=='Hot' && (mylead.Status=='Closed - Not 
Converted' && (oldversionLead.Status=='Open - Not Contacted' ||
oldversionLead.Status=='Working - Contacted') )){
                   // myLead.addError('You can not change the status of this Lead');
                    Task newTask=new Task ();
                    newTask.OwnerId=myLead.OwnerId;
                    newTask.WhoId=myLead.id;
                    newTask.Subject='Please contact with your manager to inform about
this Lead in 3 days ';
                    newTask.ActivityDate=System.today()+3;
                    //newTask.Status='Not Started';
                    //newTask.Priority='Normal';
                    newTasks.add(newTask);
                }
            }insert newTasks;
        
        }
        
/*TASK 109:Bir contact olusturulurken email veya phone bilgileri bazında 
dublicationa izin vermeyelim. 
Yani database mizde kayıtlı olan aynı email veya phone bilgisine sahip bir contact
oluşmasını engelleyelim.*/
WHEN BEFORE_INSERT {          
    Set<String> emails = new Set<String>();
    Set<String> phones = new Set<String>();
    for (Contact con : Trigger.new) {
        emails.add(con.Email);
        phones.add(con.Phone);
    }
    List<Contact> existingContacts = [SELECT Id, Email, Phone FROM Contact 
WHERE Email IN :emails OR Phone IN :phones];
    for (Contact con : Trigger.new) {
        for (Contact existingCon : existingContacts) {
            if (con.Email == existingCon.Email || con.Phone == existingCon.Phone) {
                con.Email.addError('Duplicate contact already exists with this email or 
phone number.');
            }
       } 
    }
    /*Eğer 100 den az dublication olacağından emin isek bunu kullanmak 
mantıklı olur.*/
            
         for(Contact c:Trigger.new) 
       {
           List<Contact> cntList=[Select id from Contact where email=:c.email and 
Phone=:c.Phone ];
           if(cntList.size()>0) 
          {
            c.FirstName.addError('You Cannot Create the Duplicate Contact'); 
            
          }
       } 
/*TASK 110:Bir Opportunity update edildiğinde eğer Stage i Prospecting ise, yapılan
değişiklik stage ile ilgili değilse ve opportunity nin olusturulma tarihinden itibaren
en az 30 gün geçmiş ise Descriptiona bir uyarı yazdıralım. */    
WHEN BEFORE_UPDATE  {
            for(Opportunity opp:Trigger.new){
                Opportunity oldOpp=Trigger.oldMap.get(opp.id);
               Integer diff = opp.CreatedDate.date().daysBetween(Date.today());
                if(diff >=30 && oldOpp.StageName=='Prospecting' && 
opp.StageName=='Prospecting'){
                  opp.Description='Please make more effort to proceed '+ 
System.today();  
                }
            }      
               }       
 /*TASK 111:Bir Accountun şayet related Opportunity leri varsa o Accountun 
silinmesine engel olalım ve user ı uyaralım lütfen.*/
WHEN BEFORE_DELETE  {
           List<opportunity> relatedOpps=[Select id, Name, Accountid From 
Opportunity where Accountid IN : Trigger.old];
            for(Account acc : Trigger.old){
                if(relatedOpps.size()>0){
                    acc.addError('You can not delete Account with related opportunity');
        
                }
            }
        }
/*TASK 112:Bir contact restored edildiğinde o contactın ilişkili olduğu Accountun 
Descriptiona   Related contact ...tarihinde ...tarafından restore edildi' yazdıralım;  
ayrıca aynı contactın Description fieldını da update edebilme imkanımızı 
değerlendirelim lütfen.*/
 WHEN AFTER_UNDELETE {
         Set<id> accIds= new Set<id>();
            for(Contact cnt : Trigger.new){
                if(cnt.Accountid!=null){
                   accIds.add(cnt.Accountid); 
                }  
            }List<Account> accList=[SELECT id, Description FROM Account Where id 
IN : accIds];
            for(Account acc :accList){
                acc.Description='The related contact restored'+' on '+ system.today()
+' by '+system.UserInfo.getName();     
            }update accList;
        }
 /*TASK 113:Account objectinde yeni bir kayıt oluşturulduğunda, Number of 
Locations fieldına girilen değer kadar contact olusturulmasını (Contact of Location
1, Contact of Location 2...)sağlayalım lütfen.*/
 WHEN AFTER_INSERT   { 
            List<Contact> cntList=new List<Contact>();            
            for(Account acc : Trigger.new){
                 if(acc.NumberofLocations__c !=null && acc.NumberofLocations__c > 
0){
                    for(Integer i=1; i<=acc.NumberofLocations__c; i++){
                    Contact newCont=new Contact();
                    newcont.LastName='Contact of '+acc.Name+' '+i;
                    newCont.Accountid=acc.id;
                    newCont.Phone='1'.Repeat(i);
                      cntList.add(newCont);  
                    }      
                }
            } insert cntList;   }      
/*TASK 114: Öncelikle Opportunity objectinde DateTime data type inde 
'Account Update Time' isimli  bir field oluşturalım.Bir Account update edildiğinde, 
o Accountun ilgili tüm Opportunity lerinin Account Update Time fieldının bu 
updatein zamanını gösterecek şekilde assignmentını sağlayalım lütfen*/
            WHEN AFTER_UPDATE   {
            Set<id> accIds=new Set <id>();
                        
            for(Account acc: Trigger.new){
                accIds.add(acc.id);
            }
        Map<id,Opportunity> oppMap=new Map<id,Opportunity>( [Select id, 
Account_Update_Time__c, Account.LastModifiedDate 
                                                               FROM Opportunity 
                                                               Where Accountid IN : accIds]);
            for(Opportunity opp : oppMap.values()){
              
oppMap.values().Account_Update_Time__c=oppMap.values().Account.LastModifie
dDate;
                
                
            } try {
            update oppMap.values(); 
        } catch(Exception e) {
            System.debug('@@@@Exception : '+e.getMessage());
        } 
    }
/*TASK 115: Bir opportunity closed won olduğunda onunla ilgili tüm tasklerin 
Statulerinin completed olmasını sağlayalım lütfen.*/
           WHEN AFTER_UPDATE   { 
            Set<id> oppIds=new Set<id>();
            For(Opportunity opp: Trigger.new){
                
                if(opp.IsClosed==true && opp.StageName=='Closed Won'  && 
Trigger.oldMap.get(opp.id).stageName!='Closed Won'){
                 oppIds.add(opp.id);                    
                }
            }
            List<Task> taskToUpdate=[Select id, Whatid From Task Where Whatid 
IN :oppIds ];
            
                for(Task t : taskToUpdate){
                    t.Status='Completed';
                   } update taskToUpdate;
            }  
/*TASK 116: Öncelikle Name i “Batch Apex” olan (Batch Apex 1, Batch Apex 2, 
Batch Apex 3...) 300 adet  account oluşturalım.  Sonra da Asyn apex (Batch Apex)
kullanarak bu accountların ratingini “Warm” , billing City’i Ankara yapalım lütfen.*/
public class BatchApexAccountUpdate implements 
Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext BC) {
        // collect the batches of records or objects to be passed to execute
         
       
       return Database.getQueryLocator([SELECT Id, Name, BillingCity FROM 
Account Where Name like 'Batch%' ]);
    }
     
    public void execute(Database.BatchableContext BC, List<Account> accList) {
        
        // process each batch of records default size is 200
        
        for(Account acc : accList) {        
            //Update the Account Rating, name, billing City 
            acc.Rating ='Warm';
           acc.Name=acc.Name+' Test';
          acc.BillingCity='Ankara';
                  }
        try {
            update accList; 
        } catch(Exception e) {
            System.debug(e);
        } 
    }
    public void finish(Database.BatchableContext BC) {
        // execute any post-processing operations like sending email
    }
}
/*ASK 117: Asyn Apex  (Queueable apex) kullanarak,  yukarıda oluşturduğumuz 
Accountların Type fieldını ‘Prospect’ yapalım lütfen.*/
public class QueueableApexUpdateAccount implements Queueable { 
    public void execute(QueueableContext context) {
       List<Account> accList=[Select id, Name, BillingCity From Account Where 
Name like 'Batch%'];
        for(Account acc : accList){
           acc.type ='Prospect';
               } try {
            
           update accList;
        } catch(Exception e) {
            System.debug(e);
        } } }
/*TASK 118: Her Pazar saat 20.30 da, isminde 'Apex' geçen Accountların 
orgumuzdan silinmesini sağlayalım lütfen.*/
public class BatchApexToDeleteAccounts implements 
Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext BC) {
        // collect the batches of records or objects to be passed to execute
         
       
       return Database.getQueryLocator([SELECT Id, Name, BillingCity FROM 
Account Where Name like '%Apex%' ]);
    }
     
    public void execute(Database.BatchableContext BC, List<Account> accList) {
        if(accList.size()>0){
            try {
            delete accList; 
        } catch(Exception e) {
            System.debug(e);
        } 
        }
        
    }
    public void finish(Database.BatchableContext BC) {
        // execute any post-processing operations like sending email
    }
}
//Scheduleable Class
public class ScheduleableApexToDeleteAccounts implements Schedulable {
public void execute(SchedulableContext SC) {
    BatchApexToDeleteAccounts objForDeletion= new 
BatchApexToDeleteAccounts();
    Database.executeBatch(objForDeletion,50);
}
}
//Anonymous Window
ScheduleableApexToDeleteAccounts objToSchedule = new 
ScheduleableApexToDeleteAccounts();
String cronExp = '0 30 20 ? * SUN *';
System.Schedule('Delete Accounts with name Apex' , cronExp , objToSchedule);
TASK 119: Orgumuzda oluşan her yeni Accountun Rating inin Warm ve Active 
olmasını sağlayan bir Trigger yazalım ve bu triggerın amaca uygun çalısıp 
çalısmadığının kontrolünü, yazacağımız bir test class ile yapalım lütfen.
trigger AccountTriggerforTestClass on Account (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        for(Account acc : Trigger.new){
           acc.Rating='Warm';
            acc.Active__c='Yes';
        }  
    }
}
//Test Class
@isTest
public class TestAccountTriggerforTestClass {
    @isTest
    public static void TestInsert(){
       
       
//Create an instance of an object on which you want to check this trigger is 
working or not. 
  Account a1 = new Account();
        a1.name='Yigit Corp';
        insert a1;
        
        Account acc =[SELECT Id, Rating, active__c FROM Account WHERE  id =: 
a1.Id];
       
  assert.areEqual('Warm', acc.Rating);
        assert.areEqual('Yes', acc.Active__c);
   
  
}
 }
/*TASK 120: Bir sayının tek ya da çift sayı olduğunu bir text ile return eden bir 
method  ve bu methodun test class ını yazalım lütfen.*/