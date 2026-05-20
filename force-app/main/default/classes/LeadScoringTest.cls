/**
 * @description Test class for Lead_Score__c field and related functionality
 * @group Tests
 */
@isTest
private class LeadScoringTest {

    /**
     * @description Test lead score field accepts valid decimal values
     */
    @isTest
    static void testLeadScoreValidDecimal() {
        // Arrange
        Lead testLead = new Lead(
            FirstName = 'John',
            LastName = 'Smith',
            Company = 'Acme Corp',
            Email = 'john.smith@acme.com',
            Lead_Score__c = 85.50
        );

        // Act
        Test.startTest();
        insert testLead;
        Test.stopTest();

        // Assert
        Lead result = [SELECT Id, Lead_Score__c FROM Lead WHERE Id = :testLead.Id];
        System.assertEquals(85.50, result.Lead_Score__c, 'Lead score should match inserted value');
    }

    /**
     * @description Test lead score update functionality
     */
    @isTest
    static void testLeadScoreUpdate() {
        // Arrange
        Lead testLead = new Lead(
            FirstName = 'Jane',
            LastName = 'Doe',
            Company = 'Tech Solutions',
            Email = 'jane.doe@techsolutions.com',
            Lead_Score__c = 50.00
        );
        insert testLead;

        // Act
        Test.startTest();
        testLead.Lead_Score__c = 95.75;
        update testLead;
        Test.stopTest();

        // Assert
        Lead result = [SELECT Id, Lead_Score__c FROM Lead WHERE Id = :testLead.Id];
        System.assertEquals(95.75, result.Lead_Score__c, 'Lead score should be updated');
    }

    /**
     * @description Test bulk lead insert with scores
     */
    @isTest
    static void testBulkLeadScoreInsert() {
        // Arrange
        List<Lead> testLeads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            testLeads.add(new Lead(
                FirstName = 'Test',
                LastName = 'Lead ' + i,
                Company = 'Test Company ' + i,
                Email = 'test' + i + '@example.com',
                Lead_Score__c = Math.mod(i, 100) + 0.50
            ));
        }

        // Act
        Test.startTest();
        insert testLeads;
        Test.stopTest();

        // Assert
        List<Lead> results = [SELECT Id, Lead_Score__c FROM Lead WHERE Id IN :testLeads];
        System.assertEquals(200, results.size(), 'All leads should be inserted');
        for (Lead result : results) {
            System.assertNotEquals(null, result.Lead_Score__c, 'Lead score should not be null');
        }
    }

    /**
     * @description Test lead score validation - max value
     */
    @isTest
    static void testLeadScoreMaxValue() {
        // Arrange
        Lead testLead = new Lead(
            FirstName = 'Max',
            LastName = 'Score',
            Company = 'High Value Corp',
            Email = 'max@highvalue.com',
            Lead_Score__c = 999.99
        );

        // Act
        Test.startTest();
        insert testLead;
        Test.stopTest();

        // Assert
        Lead result = [SELECT Id, Lead_Score__c FROM Lead WHERE Id = :testLead.Id];
        System.assertEquals(999.99, result.Lead_Score__c, 'Maximum lead score should be accepted');
    }

    /**
     * @description Test lead score null value (optional field)
     */
    @isTest
    static void testLeadScoreNullValue() {
        // Arrange
        Lead testLead = new Lead(
            FirstName = 'No',
            LastName = 'Score',
            Company = 'New Lead Corp',
            Email = 'noscore@newlead.com',
            Lead_Score__c = null
        );

        // Act
        Test.startTest();
        insert testLead;
        Test.stopTest();

        // Assert
        Lead result = [SELECT Id, Lead_Score__c FROM Lead WHERE Id = :testLead.Id];
        System.assertEquals(null, result.Lead_Score__c, 'Lead score can be null');
    }
}
