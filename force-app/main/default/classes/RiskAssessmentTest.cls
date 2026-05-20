/**
 * @description Test class for Risk_Score__c field on Opportunity
 * @group Tests
 */
@isTest
private class RiskAssessmentTest {

    /**
     * @description Test risk score field accepts valid integer values
     */
    @isTest
    static void testRiskScoreValidInteger() {
        // Arrange
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Opportunity testOpp = new Opportunity(
            Name = 'High Risk Deal',
            AccountId = testAccount.Id,
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(30),
            Risk_Score__c = 750
        );

        // Act
        Test.startTest();
        insert testOpp;
        Test.stopTest();

        // Assert
        Opportunity result = [SELECT Id, Risk_Score__c FROM Opportunity WHERE Id = :testOpp.Id];
        System.assertEquals(750, result.Risk_Score__c, 'Risk score should match inserted value');
    }

    /**
     * @description Test risk score update based on stage change
     */
    @isTest
    static void testRiskScoreUpdateOnStageChange() {
        // Arrange
        Account testAccount = new Account(Name = 'Tech Corp');
        insert testAccount;

        Opportunity testOpp = new Opportunity(
            Name = 'Software License Deal',
            AccountId = testAccount.Id,
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(60),
            Risk_Score__c = 500
        );
        insert testOpp;

        // Act
        Test.startTest();
        testOpp.StageName = 'Negotiation/Review';
        testOpp.Risk_Score__c = 250;
        update testOpp;
        Test.stopTest();

        // Assert
        Opportunity result = [SELECT Id, Risk_Score__c, StageName FROM Opportunity WHERE Id = :testOpp.Id];
        System.assertEquals(250, result.Risk_Score__c, 'Risk score should decrease as deal progresses');
        System.assertEquals('Negotiation/Review', result.StageName, 'Stage should be updated');
    }

    /**
     * @description Test bulk opportunity insert with risk scores
     */
    @isTest
    static void testBulkRiskScoreInsert() {
        // Arrange
        Account testAccount = new Account(Name = 'Bulk Test Account');
        insert testAccount;

        List<Opportunity> testOpps = new List<Opportunity>();
        for (Integer i = 0; i < 200; i++) {
            testOpps.add(new Opportunity(
                Name = 'Deal ' + i,
                AccountId = testAccount.Id,
                StageName = 'Qualification',
                CloseDate = Date.today().addDays(30 + i),
                Risk_Score__c = Math.mod(i * 5, 999)
            ));
        }

        // Act
        Test.startTest();
        insert testOpps;
        Test.stopTest();

        // Assert
        List<Opportunity> results = [SELECT Id, Risk_Score__c FROM Opportunity WHERE Id IN :testOpps];
        System.assertEquals(200, results.size(), 'All opportunities should be inserted');
        for (Opportunity result : results) {
            System.assertNotEquals(null, result.Risk_Score__c, 'Risk score should not be null');
            System.assert(result.Risk_Score__c >= 0 && result.Risk_Score__c <= 999, 'Risk score should be in valid range');
        }
    }

    /**
     * @description Test risk score boundaries (0-999)
     */
    @isTest
    static void testRiskScoreBoundaries() {
        // Arrange
        Account testAccount = new Account(Name = 'Boundary Test Account');
        insert testAccount;

        List<Opportunity> testOpps = new List<Opportunity>{
            new Opportunity(
                Name = 'Zero Risk',
                AccountId = testAccount.Id,
                StageName = 'Closed Won',
                CloseDate = Date.today(),
                Risk_Score__c = 0
            ),
            new Opportunity(
                Name = 'Max Risk',
                AccountId = testAccount.Id,
                StageName = 'Prospecting',
                CloseDate = Date.today().addDays(90),
                Risk_Score__c = 999
            )
        };

        // Act
        Test.startTest();
        insert testOpps;
        Test.stopTest();

        // Assert
        List<Opportunity> results = [SELECT Id, Name, Risk_Score__c FROM Opportunity WHERE Id IN :testOpps ORDER BY Risk_Score__c];
        System.assertEquals(0, results[0].Risk_Score__c, 'Minimum risk score should be 0');
        System.assertEquals(999, results[1].Risk_Score__c, 'Maximum risk score should be 999');
    }

    /**
     * @description Test risk score null value (optional field)
     */
    @isTest
    static void testRiskScoreNullValue() {
        // Arrange
        Account testAccount = new Account(Name = 'No Risk Score Account');
        insert testAccount;

        Opportunity testOpp = new Opportunity(
            Name = 'Unscored Deal',
            AccountId = testAccount.Id,
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(30),
            Risk_Score__c = null
        );

        // Act
        Test.startTest();
        insert testOpp;
        Test.stopTest();

        // Assert
        Opportunity result = [SELECT Id, Risk_Score__c FROM Opportunity WHERE Id = :testOpp.Id];
        System.assertEquals(null, result.Risk_Score__c, 'Risk score can be null');
    }

    /**
     * @description Test risk score query aggregation
     */
    @isTest
    static void testRiskScoreAggregation() {
        // Arrange
        Account testAccount = new Account(Name = 'Aggregate Test Account');
        insert testAccount;

        List<Opportunity> testOpps = new List<Opportunity>{
            new Opportunity(Name = 'Deal 1', AccountId = testAccount.Id, StageName = 'Prospecting', CloseDate = Date.today().addDays(30), Risk_Score__c = 100),
            new Opportunity(Name = 'Deal 2', AccountId = testAccount.Id, StageName = 'Prospecting', CloseDate = Date.today().addDays(30), Risk_Score__c = 200),
            new Opportunity(Name = 'Deal 3', AccountId = testAccount.Id, StageName = 'Prospecting', CloseDate = Date.today().addDays(30), Risk_Score__c = 300)
        };
        insert testOpps;

        // Act
        Test.startTest();
        AggregateResult[] results = [
            SELECT AVG(Risk_Score__c) avgRisk, MAX(Risk_Score__c) maxRisk, MIN(Risk_Score__c) minRisk
            FROM Opportunity
            WHERE AccountId = :testAccount.Id
        ];
        Test.stopTest();

        // Assert
        System.assertEquals(200, results[0].get('avgRisk'), 'Average risk score should be 200');
        System.assertEquals(300, results[0].get('maxRisk'), 'Max risk score should be 300');
        System.assertEquals(100, results[0].get('minRisk'), 'Min risk score should be 100');
    }
}
