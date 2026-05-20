import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class AlmHomeDashboard extends NavigationMixin(LightningElement) {

    navigateToDocumentation() {
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
                apiName: 'ALM_Documentation'
            }
        });
    }

    navigateToPipeline() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'DevopsPipeline',
                actionName: 'list'
            },
            state: {
                filterName: 'Recent'
            }
        });
    }

    navigateToTests() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'ApexTestResult',
                actionName: 'list'
            }
        });
    }

    navigateToFeatureFlags() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Feature_Flag__mdt',
                actionName: 'list'
            }
        });
    }

    openGitHub() {
        window.open('https://github.com/Tarateatoe/salesforce-devops-demo', '_blank');
    }

    openGitHubActions() {
        window.open('https://github.com/Tarateatoe/salesforce-devops-demo/actions', '_blank');
    }
}
