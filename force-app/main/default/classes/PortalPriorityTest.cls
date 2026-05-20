/**
 * @description Test class for Portal_Priority__c field on Case
 * @group Tests
 */
@isTest
private class PortalPriorityTest {

    /**
     * @description Test portal priority picklist values
     */
    @isTest
    static void testPortalPriorityPicklistValues() {
        // Arrange & Act
        Test.startTest();
        Case lowPriorityCase = new Case(
            Subject = 'Low Priority Issue',
            Portal_Priority__c = 'Low'
        );
        Case mediumPriorityCase = new Case(
            Subject = 'Medium Priority Issue',
            Portal_Priority__c = 'Medium'
        );
        Case highPriorityCase = new Case(
            Subject = 'High Priority Issue',
            Portal_Priority__c = 'High'
        );
        Case criticalPriorityCase = new Case(
            Subject = 'Critical Priority Issue',
            Portal_Priority__c = 'Critical'
        );

        List<Case> cases = new List<Case>{lowPriorityCase, mediumPriorityCase, highPriorityCase, criticalPriorityCase};
        insert cases;
        Test.stopTest();

        // Assert
        List<Case> results = [SELECT Id, Portal_Priority__c FROM Case WHERE Id IN :cases ORDER BY Subject];
        System.assertEquals(4, results.size(), 'All cases should be inserted');
        System.assertEquals('Critical', results[0].Portal_Priority__c, 'Critical priority should be set');
        System.assertEquals('High', results[1].Portal_Priority__c, 'High priority should be set');
        System.assertEquals('Low', results[2].Portal_Priority__c, 'Low priority should be set');
        System.assertEquals('Medium', results[3].Portal_Priority__c, 'Medium priority should be set');
    }

    /**
     * @description Test default portal priority value (Medium)
     */
    @isTest
    static void testPortalPriorityDefaultValue() {
        // Arrange
        Case testCase = new Case(
            Subject = 'Test Case Without Priority'
            // Portal_Priority__c not specified - should use default
        );

        // Act
        Test.startTest();
        insert testCase;
        Test.stopTest();

        // Assert
        Case result = [SELECT Id, Portal_Priority__c FROM Case WHERE Id = :testCase.Id];
        System.assertEquals('Medium', result.Portal_Priority__c, 'Default portal priority should be Medium');
    }

    /**
     * @description Test portal priority update
     */
    @isTest
    static void testPortalPriorityUpdate() {
        // Arrange
        Case testCase = new Case(
            Subject = 'Escalating Issue',
            Portal_Priority__c = 'Low'
        );
        insert testCase;

        // Act
        Test.startTest();
        testCase.Portal_Priority__c = 'Critical';
        update testCase;
        Test.stopTest();

        // Assert
        Case result = [SELECT Id, Portal_Priority__c FROM Case WHERE Id = :testCase.Id];
        System.assertEquals('Critical', result.Portal_Priority__c, 'Portal priority should be updated to Critical');
    }

    /**
     * @description Test bulk case insert with various priorities
     */
    @isTest
    static void testBulkPortalPriorityInsert() {
        // Arrange
        List<Case> testCases = new List<Case>();
        List<String> priorities = new List<String>{'Low', 'Medium', 'High', 'Critical'};

        for (Integer i = 0; i < 200; i++) {
            testCases.add(new Case(
                Subject = 'Bulk Case ' + i,
                Portal_Priority__c = priorities[Math.mod(i, 4)]
            ));
        }

        // Act
        Test.startTest();
        insert testCases;
        Test.stopTest();

        // Assert
        List<Case> results = [SELECT Id, Portal_Priority__c FROM Case WHERE Id IN :testCases];
        System.assertEquals(200, results.size(), 'All cases should be inserted');

        // Verify distribution of priorities
        Integer lowCount = 0, mediumCount = 0, highCount = 0, criticalCount = 0;
        for (Case c : results) {
            if (c.Portal_Priority__c == 'Low') lowCount++;
            else if (c.Portal_Priority__c == 'Medium') mediumCount++;
            else if (c.Portal_Priority__c == 'High') highCount++;
            else if (c.Portal_Priority__c == 'Critical') criticalCount++;
        }

        System.assertEquals(50, lowCount, 'Should have 50 Low priority cases');
        System.assertEquals(50, mediumCount, 'Should have 50 Medium priority cases');
        System.assertEquals(50, highCount, 'Should have 50 High priority cases');
        System.assertEquals(50, criticalCount, 'Should have 50 Critical priority cases');
    }

    /**
     * @description Test portal priority query and filtering
     */
    @isTest
    static void testPortalPriorityQuery() {
        // Arrange
        List<Case> testCases = new List<Case>{
            new Case(Subject = 'Critical Case 1', Portal_Priority__c = 'Critical'),
            new Case(Subject = 'Critical Case 2', Portal_Priority__c = 'Critical'),
            new Case(Subject = 'Low Case 1', Portal_Priority__c = 'Low'),
            new Case(Subject = 'Medium Case 1', Portal_Priority__c = 'Medium')
        };
        insert testCases;

        // Act
        Test.startTest();
        List<Case> criticalCases = [SELECT Id, Portal_Priority__c FROM Case WHERE Portal_Priority__c = 'Critical'];
        List<Case> highAndCritical = [SELECT Id, Portal_Priority__c FROM Case WHERE Portal_Priority__c IN ('High', 'Critical')];
        Test.stopTest();

        // Assert
        System.assertEquals(2, criticalCases.size(), 'Should find 2 critical cases');
        System.assertEquals(2, highAndCritical.size(), 'Should find 2 high/critical cases');
    }

    /**
     * @description Test portal priority with case escalation scenario
     */
    @isTest
    static void testPortalPriorityEscalation() {
        // Arrange
        Case testCase = new Case(
            Subject = 'Customer Complaint',
            Status = 'New',
            Portal_Priority__c = 'Medium'
        );
        insert testCase;

        // Act - Simulate escalation workflow
        Test.startTest();
        testCase.Status = 'Escalated';
        testCase.Portal_Priority__c = 'High';
        update testCase;

        // Further escalation
        testCase.Portal_Priority__c = 'Critical';
        update testCase;
        Test.stopTest();

        // Assert
        Case result = [SELECT Id, Status, Portal_Priority__c FROM Case WHERE Id = :testCase.Id];
        System.assertEquals('Escalated', result.Status, 'Case should be escalated');
        System.assertEquals('Critical', result.Portal_Priority__c, 'Portal priority should be Critical after escalation');
    }

    /**
     * @description Test portal priority aggregation by type
     */
    @isTest
    static void testPortalPriorityAggregation() {
        // Arrange
        List<Case> testCases = new List<Case>{
            new Case(Subject = 'Test 1', Portal_Priority__c = 'Critical'),
            new Case(Subject = 'Test 2', Portal_Priority__c = 'Critical'),
            new Case(Subject = 'Test 3', Portal_Priority__c = 'High'),
            new Case(Subject = 'Test 4', Portal_Priority__c = 'Medium'),
            new Case(Subject = 'Test 5', Portal_Priority__c = 'Low')
        };
        insert testCases;

        // Act
        Test.startTest();
        AggregateResult[] results = [
            SELECT Portal_Priority__c priority, COUNT(Id) cnt
            FROM Case
            WHERE Id IN :testCases
            GROUP BY Portal_Priority__c
            ORDER BY COUNT(Id) DESC
        ];
        Test.stopTest();

        // Assert
        System.assertEquals(4, results.size(), 'Should have 4 different priority groups');
        System.assertEquals('Critical', results[0].get('priority'), 'Critical should have highest count');
        System.assertEquals(2, results[0].get('cnt'), 'Critical should have 2 cases');
    }
}
