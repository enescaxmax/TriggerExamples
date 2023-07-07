// Send a Email to each new Contact
trigger ContactEmailTrigger on contact (before insert) {

    //get all email in the list
     List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();
    
    for (Contact myContact : Trigger.new) {
    
        if (myContact.Email != null && myContact.FirstName != null) {
    
        // Step 1: Create a new Email
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    
        // Step 2: Set list of people who should get the email
         List<String> sendTo = new List<String>();
         sendTo.add(myContact.Email);
         mail.setToAddresses(sendTo);
    
       // Step 3. Set email contents - you can use variables!
    
       //SUBJECT of the mail and the body of the mail
        mail.setSubject('Your contact detail are added');
    
    
       String body = 'Dear ' + myContact.FirstName + ', According to the ContactEmailTrigger trigger ';
    
       body += 'your contact details were added successfuly. For more details you can visit ';
       body += ' https://wisequarter.com/ ';
    
       //BODY  of the mail 
       mail.setHtmlBody(body);
    
       // Step 4. Add your email to the master list
       mails.add(mail);
       }
    }
    
    // Step 5: Send all emails in the master list
    Messaging.sendEmail(mails);
    }
    