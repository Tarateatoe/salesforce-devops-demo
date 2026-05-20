import { LightningElement, track } from 'lwc';

export default class AlmDocumentationCenter extends LightningElement {
    @track activeTab = 'overview';

    guideContent = `
        <h3>Overview</h3>
        <p>This comprehensive guide covers all aspects of the Application Lifecycle Management demo.</p>
        <h4>Topics Covered:</h4>
        <ul>
            <li><strong>DevOps Center</strong> - Source-driven development with Git integration</li>
            <li><strong>Automated Testing</strong> - Apex test classes with 100% coverage</li>
            <li><strong>CI/CD Pipeline</strong> - GitHub Actions workflows</li>
            <li><strong>Feature Flags</strong> - Controlled rollouts and canary releases</li>
            <li><strong>Code Quality</strong> - SFDX Scanner integration</li>
            <li><strong>Monitoring</strong> - Deployment tracking and audit trails</li>
        </ul>
        <h4>Key Components:</h4>
        <ul>
            <li>4 Test Classes (LeadScoringTest, RiskAssessmentTest, PortalPriorityTest, FeatureFlagServiceTest)</li>
            <li>25+ Test Methods covering all scenarios</li>
            <li>5-Stage CI/CD Pipeline (Validate → Test → QA → Staging → Production)</li>
            <li>3 Feature Flags with rollout control (0%, 50%, 100%)</li>
            <li>Complete monitoring queries and audit trail access</li>
        </ul>
    `;

    runbookContent = `
        <h3>Deployment Workflow</h3>
        <h4>Phase 1: Development</h4>
        <ol>
            <li>Create work item in DevOps Center</li>
            <li>Create feature branch (WI-XXXXXX)</li>
            <li>Develop and test locally</li>
            <li>Commit changes to Git</li>
            <li>Create pull request</li>
        </ol>
        <h4>Phase 2: QA Testing</h4>
        <ol>
            <li>Merge PR to dev branch (triggers auto-deployment)</li>
            <li>CI/CD runs: validate, test, deploy to QA</li>
            <li>Run regression tests</li>
            <li>Fix defects if found</li>
        </ol>
        <h4>Phase 3: Staging (UAT)</h4>
        <ol>
            <li>Merge dev → qa branch</li>
            <li>Auto-deploy to staging</li>
            <li>User acceptance testing</li>
            <li>Business sign-off</li>
        </ol>
        <h4>Phase 4: Production</h4>
        <ol>
            <li>Notify stakeholders</li>
            <li>Backup production metadata</li>
            <li>Merge qa → main branch</li>
            <li>Validation deployment (dry-run)</li>
            <li>Actual deployment</li>
            <li>Run smoke tests</li>
            <li>Gradual feature rollout (5% → 25% → 50% → 100%)</li>
        </ol>
    `;

    handleTabChange(event) {
        this.activeTab = event.target.value;
    }

    downloadCompleteGuide() {
        // Open the Complete Guide in new window
        const url = 'https://github.com/Tarateatoe/salesforce-devops-demo/blob/main/.agents/artifacts/ALM_COMPLETE_GUIDE.md';
        window.open(url, '_blank');
    }

    downloadRunbook() {
        // Open the Deployment Runbook in new window
        const url = 'https://github.com/Tarateatoe/salesforce-devops-demo/blob/main/.agents/artifacts/DEPLOYMENT_RUNBOOK.md';
        window.open(url, '_blank');
    }

    openGitHub() {
        window.open('https://github.com/Tarateatoe/salesforce-devops-demo', '_blank');
    }
}
