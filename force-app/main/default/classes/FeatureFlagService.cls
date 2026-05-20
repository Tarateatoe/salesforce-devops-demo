/**
 * @description Service class for managing feature flags
 * @group ALM
 */
public with sharing class FeatureFlagService {

    private static Map<String, Feature_Flag__mdt> flagCache;

    /**
     * @description Check if a feature is enabled
     * @param featureName Developer name of the feature flag
     * @return Boolean indicating if feature is enabled
     */
    public static Boolean isEnabled(String featureName) {
        Feature_Flag__mdt flag = getFeatureFlag(featureName);
        return flag != null && flag.Is_Enabled__c;
    }

    /**
     * @description Check if a feature is enabled for a specific user (canary release)
     * @param featureName Developer name of the feature flag
     * @param userId User ID to check against rollout percentage
     * @return Boolean indicating if feature is enabled for this user
     */
    public static Boolean isEnabledForUser(String featureName, Id userId) {
        Feature_Flag__mdt flag = getFeatureFlag(featureName);

        if (flag == null || !flag.Is_Enabled__c) {
            return false;
        }

        // If rollout is 100%, feature is enabled for everyone
        if (flag.Rollout_Percentage__c >= 100) {
            return true;
        }

        // If rollout is 0%, feature is disabled for everyone
        if (flag.Rollout_Percentage__c <= 0) {
            return false;
        }

        // Canary release: Use hash of user ID to determine if user is in rollout percentage
        Integer userHash = Math.abs(userId.hashCode());
        Decimal userPercentile = Math.mod(userHash, 100);

        return userPercentile < flag.Rollout_Percentage__c;
    }

    /**
     * @description Get rollout percentage for a feature
     * @param featureName Developer name of the feature flag
     * @return Decimal rollout percentage (0-100)
     */
    public static Decimal getRolloutPercentage(String featureName) {
        Feature_Flag__mdt flag = getFeatureFlag(featureName);
        return flag != null ? flag.Rollout_Percentage__c : 0;
    }

    /**
     * @description Get all feature flags
     * @return Map of feature flags by developer name
     */
    public static Map<String, Feature_Flag__mdt> getAllFlags() {
        if (flagCache == null) {
            loadFlags();
        }
        return flagCache;
    }

    /**
     * @description Get a specific feature flag
     * @param featureName Developer name of the feature flag
     * @return Feature_Flag__mdt record or null
     */
    private static Feature_Flag__mdt getFeatureFlag(String featureName) {
        if (flagCache == null) {
            loadFlags();
        }
        return flagCache.get(featureName);
    }

    /**
     * @description Load feature flags into cache
     */
    private static void loadFlags() {
        flagCache = new Map<String, Feature_Flag__mdt>();

        List<Feature_Flag__mdt> flags = [
            SELECT
                DeveloperName,
                MasterLabel,
                Description__c,
                Is_Enabled__c,
                Rollout_Percentage__c
            FROM Feature_Flag__mdt
        ];

        for (Feature_Flag__mdt flag : flags) {
            flagCache.put(flag.DeveloperName, flag);
        }
    }

    /**
     * @description Example usage in code
     */
    public static void exampleUsage() {
        // Simple on/off check
        if (isEnabled('Knowledge_Base_Widget')) {
            // Show knowledge base widget
            System.debug('Knowledge Base Widget is enabled');
        }

        // Canary release check
        Id currentUserId = UserInfo.getUserId();
        if (isEnabledForUser('Lead_Scoring_AI', currentUserId)) {
            // Use AI-powered lead scoring
            System.debug('AI Lead Scoring enabled for this user');
        } else {
            // Use traditional lead scoring
            System.debug('Traditional lead scoring');
        }

        // Check rollout percentage
        Decimal rollout = getRolloutPercentage('Lead_Scoring_AI');
        System.debug('Lead Scoring AI rollout: ' + rollout + '%');
    }
}
