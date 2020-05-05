/* 
 * This class can be safely deleted from your org. 
 * It was only used to ensure 100% test coverage
 * for the managed package installation.
 */

@IsTest
private class InstallationTests {

    @testSetup
    static void setupData() {

		Account testAcct = new Account();
        testAcct.name = 'Test Account';
        testAcct.type = 'Customer - Direct';
        insert testAcct;
        
        Opportunity testOpp = new Opportunity(); 
        testOpp.name = 'Test Opportunity';
        testOpp.AccountId = testAcct.id;
        testOpp.type = 'New Project';
        testOpp.CloseDate = system.today();
        testOpp.StageName = 'Negotiation/Review';
        testOpp.Amount = 500000;
        insert testOpp;
        
        ServiceTokens__c servToken = new ServiceTokens__c();
        servToken.Name = 'ProjectServiceToken';
        servToken.Token__c = '299ad19f-9193-42f5-8019-1ba7368612ad';
        insert servToken;
        
    }

    //Test empty trigger stub
    static @istest void testProjectTrigger() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Project__c p = new Project__c();
        p.Opportunity__c = opp.Id;
        insert p;
    }
    
    //Test empty service stub
	static @istest void testProjectCalloutServiceForInstall() {
        Opportunity op = [select id from opportunity where name = 'Test Opportunity' limit 1][0];
        List<Id> l = new List<Id>();
        l.add(op.Id);
	    ProjectCalloutService.postOpportunityToPMS(l);
	}

}
