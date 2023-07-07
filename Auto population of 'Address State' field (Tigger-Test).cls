@isTest
public class Lead_Trigger_Test {
    @isTest static void testLeadTrigger() {
        // Test verilerini oluşturma
        Lead testLeaddd = new Lead();
        
        testLeaddd.LastName = 'Doe';
        testLeaddd.LeadSource = 'Website';
        testLeaddd.State__c = 'AR: Arkansas';
        testLeaddd.EIN__c = '748395872';
        testLeaddd.SSN__c = '741395872';
        
        
        insert testLeaddd;
        // Test kaydını ekleyin
        // Test.startTest();
        

        // Tetikleyici tarafından yürütülen işlemlerin tamamlanmasını bekleyin
        // Test.stopTest();

        // Sonuçları kontrol etme
        Lead testLead = [SELECT Id, State FROM Lead WHERE Id =:testLeaddd.Id];
       
        
        System.assertEquals('AR: Arkansas', testLead.state, 'State field was not populated correctly.');
        System.assertNotEquals('55: Samsun', testLead.state);
        
            }
    }