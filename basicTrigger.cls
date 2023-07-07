/*
If an account is created 
No matter what The rating of account should be ‘Hot’
and BillingState should be ‘ARKANSAS’
*/

Account yeniAccount = new Account();

yeniAccount.name= 'AAAAAAAA Wise ';
insert yeniAccount;
  



List<Account> accList = new List<Account>();
for( integer i=1 ; i<450 ; i++){
     Account yeniAccount = new Account();
    
    yeniAccount.name= 'Wise ' + i;
   accList.add(yeniAccount);
      
}

insert accList;


 /*   
system.debug('KAC DEFA CALISTI');
system.debug('Trigger.isBefore==>' + Trigger.isBefore);  // true
system.debug('Trigger.isAfter==>'  + Trigger.isAfter);  // false
system.debug('Trigger.isInsert==>' + Trigger.isInsert);  // true
system.debug('Trigger.isUpdate==>' + Trigger.isUpdate);  // false 
    
system.debug('Trigger.operationType ==>' + Trigger.operationType);  // BEFORE_INSERT
     
*/

