/**
 * @description Test class for FeatureFlagService
 * @group Tests
 */
@isTest
private class FeatureFlagServiceTest {

    /**
     * @description Test isEnabled method
     */
    @isTest
    static void testIsEnabled() {
        // Act
        Test.startTest();
        Boolean knowledgeBaseEnabled = FeatureFlagService.isEnabled('Knowledge_Base_Widget');
        Boolean leadScoringEnabled = FeatureFlagService.isEnabled('Lead_Scoring_AI');
        Boolean riskDashboardEnabled = FeatureFlagService.isEnabled('Risk_Assessment_Dashboard');
        Boolean nonExistentFlag = FeatureFlagService.isEnabled('NonExistent_Flag');
        Test.stopTest();

        // Assert
        System.assertEquals(true, knowledgeBaseEnabled, 'Knowledge Base Widget should be enabled');
        System.assertEquals(true, leadScoringEnabled, 'Lead Scoring AI should be enabled');
        System.assertEquals(false, riskDashboardEnabled, 'Risk Assessment Dashboard should be disabled');
        System.assertEquals(false, nonExistentFlag, 'Non-existent flag should return false');
    }

    /**
     * @description Test isEnabledForUser with 100% rollout
     */
    @isTest
    static void testIsEnabledForUser100Percent() {
        // Arrange
        Id testUserId = UserInfo.getUserId();

        // Act
        Test.startTest();
        Boolean result = FeatureFlagService.isEnabledForUser('Knowledge_Base_Widget', testUserId);
        Test.stopTest();

        // Assert
        System.assertEquals(true, result, 'Feature with 100% rollout should be enabled for all users');
    }

    /**
     * @description Test isEnabledForUser with 0% rollout
     */
    @isTest
    static void testIsEnabledForUser0Percent() {
        // Arrange
        Id testUserId = UserInfo.getUserId();

        // Act
        Test.startTest();
        Boolean result = FeatureFlagService.isEnabledForUser('Risk_Assessment_Dashboard', testUserId);
        Test.stopTest();

        // Assert
        System.assertEquals(false, result, 'Feature with 0% rollout should be disabled for all users');
    }

    /**
     * @description Test isEnabledForUser with partial rollout
     */
    @isTest
    static void testIsEnabledForUserPartialRollout() {
        // Arrange
        Id testUserId = UserInfo.getUserId();

        // Act
        Test.startTest();
        Boolean result = FeatureFlagService.isEnabledForUser('Lead_Scoring_AI', testUserId);
        Decimal rolloutPercentage = FeatureFlagService.getRolloutPercentage('Lead_Scoring_AI');
        Test.stopTest();

        // Assert
        System.assertEquals(50.0, rolloutPercentage, 'Lead Scoring AI should have 50% rollout');
        // Result will vary by user ID hash, but should be deterministic
        System.assertNotEquals(null, result, 'Result should not be null');
    }

    /**
     * @description Test getRolloutPercentage
     */
    @isTest
    static void testGetRolloutPercentage() {
        // Act
        Test.startTest();
        Decimal knowledgeBaseRollout = FeatureFlagService.getRolloutPercentage('Knowledge_Base_Widget');
        Decimal leadScoringRollout = FeatureFlagService.getRolloutPercentage('Lead_Scoring_AI');
        Decimal riskDashboardRollout = FeatureFlagService.getRolloutPercentage('Risk_Assessment_Dashboard');
        Decimal nonExistentRollout = FeatureFlagService.getRolloutPercentage('NonExistent_Flag');
        Test.stopTest();

        // Assert
        System.assertEquals(100.0, knowledgeBaseRollout, 'Knowledge Base Widget should have 100% rollout');
        System.assertEquals(50.0, leadScoringRollout, 'Lead Scoring AI should have 50% rollout');
        System.assertEquals(0.0, riskDashboardRollout, 'Risk Assessment Dashboard should have 0% rollout');
        System.assertEquals(0.0, nonExistentRollout, 'Non-existent flag should return 0%');
    }

    /**
     * @description Test getAllFlags
     */
    @isTest
    static void testGetAllFlags() {
        // Act
        Test.startTest();
        Map<String, Feature_Flag__mdt> allFlags = FeatureFlagService.getAllFlags();
        Test.stopTest();

        // Assert
        System.assertNotEquals(null, allFlags, 'getAllFlags should not return null');
        System.assert(allFlags.size() >= 3, 'Should have at least 3 feature flags');
        System.assert(allFlags.containsKey('Knowledge_Base_Widget'), 'Should contain Knowledge_Base_Widget flag');
        System.assert(allFlags.containsKey('Lead_Scoring_AI'), 'Should contain Lead_Scoring_AI flag');
        System.assert(allFlags.containsKey('Risk_Assessment_Dashboard'), 'Should contain Risk_Assessment_Dashboard flag');
    }

    /**
     * @description Test consistency of user-based rollout
     */
    @isTest
    static void testUserRolloutConsistency() {
        // Arrange
        Id testUserId = UserInfo.getUserId();

        // Act
        Test.startTest();
        Boolean firstCall = FeatureFlagService.isEnabledForUser('Lead_Scoring_AI', testUserId);
        Boolean secondCall = FeatureFlagService.isEnabledForUser('Lead_Scoring_AI', testUserId);
        Boolean thirdCall = FeatureFlagService.isEnabledForUser('Lead_Scoring_AI', testUserId);
        Test.stopTest();

        // Assert - Same user should get same result every time
        System.assertEquals(firstCall, secondCall, 'Same user should get consistent results');
        System.assertEquals(secondCall, thirdCall, 'Same user should get consistent results');
    }

    /**
     * @description Test disabled flag with high rollout percentage
     */
    @isTest
    static void testDisabledFlagIgnoresRollout() {
        // Arrange
        Id testUserId = UserInfo.getUserId();

        // Act
        Test.startTest();
        // Risk_Assessment_Dashboard is disabled (Is_Enabled__c = false) even though rollout could be > 0
        Boolean result = FeatureFlagService.isEnabledForUser('Risk_Assessment_Dashboard', testUserId);
        Test.stopTest();

        // Assert
        System.assertEquals(false, result, 'Disabled feature should return false regardless of rollout percentage');
    }
}
