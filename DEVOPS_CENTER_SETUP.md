# DevOps Center Demo - Quick Setup Guide

## What's Been Created

✅ **Git Repository** with realistic structure:
- **1 main branch** - Production-ready code
- **4 project branches** - One per demo project
- **6 feature branches** - Active work items with commits
- **Sample Salesforce metadata** - Fields, LWCs, Flows

### Branches Overview

| Branch | Purpose | Work Item |
|--------|---------|-----------|
| `main` | Production | - |
| `feature/enhanced-case-form` | Portal enhancement | WI-1001 (In Dev) |
| `feature/kb-integration` | KB search widget | WI-1002 (Testing) |
| `feature/sso-auth` | SSO implementation | WI-1004 (Complete) ✓ |
| `feature/auto-followup-flow` | Opp follow-ups | WI-2001 (In Dev) |
| `feature/risk-assessment-lwc` | Risk scoring | WI-2003 (Complete) ✓ |
| `feature/lead-scoring-model` | Lead scoring | WI-4001 (In Dev) |

---

## Step-by-Step Setup

### Step 1: Create GitHub Repository

1. Go to https://github.com/new
2. **Repository name:** `salesforce-devops-demo`
3. **Description:** "Salesforce DevOps Center demo with realistic projects and work items"
4. **Visibility:** Public (recommended for demos)
5. **DO NOT** check "Initialize with README"
6. Click **Create repository**

### Step 2: Push to GitHub

```bash
cd ~/claude-projects/sf-demo-scout/demo-repo
./PUSH_TO_GITHUB.sh
```

Or manually:
```bash
cd ~/claude-projects/sf-demo-scout/demo-repo
git remote add origin https://github.com/Tarateatoe/salesforce-devops-demo.git
git push -u origin main
git push origin --all
```

### Step 3: Connect to DevOps Center

1. **In your Salesforce org**, navigate to DevOps Center
   - Or go to: Setup → DevOps Center
2. Click **"Connect Repository"** or **"Get Started"**
3. Select **GitHub**
4. Click **"Authorize"** and log in to GitHub
5. Select **salesforce-devops-demo** from the list
6. Click **"Connect"**

### Step 4: Create Projects in DevOps Center

#### Project 1: Customer Portal Enhancement

1. Click **"New Project"**
2. Fill in:
   - **Name:** Customer Portal Enhancement
   - **Description:** Modernizing the customer self-service portal with new features and improved UX. Includes enhanced case management, knowledge base integration, and mobile optimization.
   - **Repository:** salesforce-devops-demo
   - **Branch:** main (or create project/customer-portal)
3. Click **"Create"**

**Create Work Items:**

| Name | Status | Branch | Description |
|------|--------|--------|-------------|
| WI-1001 | In Development | feature/enhanced-case-form | Add enhanced case creation form with file upload and priority selection |
| WI-1002 | Ready for Testing | feature/kb-integration | Integrate knowledge base search widget on portal home page |
| WI-1003 | Backlog | - | Implement mobile-responsive design for customer portal |
| WI-1004 | Completed | feature/sso-auth | Update portal authentication to support SSO with Auth0 and Okta ✓ |

#### Project 2: Sales Cloud Optimization

1. Click **"New Project"**
2. Fill in:
   - **Name:** Sales Cloud Optimization
   - **Description:** Streamlining sales processes with improved opportunity management, automated follow-ups, and enhanced forecasting capabilities.
   - **Repository:** salesforce-devops-demo
   - **Branch:** main or project/sales-optimization
3. Create Pipeline: Dev → QA → Prod

**Create Work Items:**

| Name | Status | Branch | Description |
|------|--------|--------|-------------|
| WI-2001 | In Development | feature/auto-followup-flow | Create automated follow-up email flow for opportunities |
| WI-2002 | Ready for Testing | - | Add custom forecast category fields to Opportunity |
| WI-2003 | Completed | feature/risk-assessment-lwc | Build LWC for opportunity risk assessment ✓ |

#### Project 3: Service Cloud Modernization

1. Click **"New Project"**
2. Fill in:
   - **Name:** Service Cloud Modernization
   - **Description:** Upgrading service operations with AI-powered case routing, omnichannel support, and field service integration.
   - **Repository:** salesforce-devops-demo
   - **Branch:** project/service-modernization

**Create Work Items (All Backlog):**

| Name | Status | Description |
|------|--------|-------------|
| WI-3001 | Backlog | Implement Einstein Case Classification for automatic routing |
| WI-3002 | Backlog | Configure Omnichannel presence for multiple channels |
| WI-3003 | Backlog | Integrate Field Service with Service Cloud |

#### Project 4: Marketing Automation Suite

1. Click **"New Project"**
2. Fill in:
   - **Name:** Marketing Automation Suite
   - **Description:** Building comprehensive marketing automation capabilities including lead scoring, email campaigns, and analytics dashboards.
   - **Repository:** salesforce-devops-demo
   - **Branch:** project/marketing-automation

**Create Work Items:**

| Name | Status | Branch | Description |
|------|--------|--------|-------------|
| WI-4001 | In Development | feature/lead-scoring-model | Create lead scoring model based on engagement metrics |
| WI-4002 | Completed | - | Build Campaign ROI Dashboard with Einstein Analytics ✓ |

---

## Demo Flow

### Opening (2 min)
"We've been using DevOps Center to manage our Salesforce development lifecycle across four major initiatives..."

**Show Projects Dashboard:**
- 4 active projects across different clouds
- Real-time status and progress indicators

### Deep Dive - Customer Portal Project (5 min)

**Work Item View:**
- "Here's our Kanban board showing work at different stages"
- Point out: Backlog → In Development → Testing → Completed
- Open WI-1001 to show: assignee, branch, description, metadata changes

**Branch Strategy:**
- "Each work item has its own feature branch"
- Show branch list in GitHub
- "Developers can work in parallel without conflicts"

**Pipeline View:**
- "Changes flow through our pipeline: Dev → QA → Production"
- Show promotion controls
- "One-click deployment with full audit trail"

### Key Benefits Highlight (3 min)

1. **Version Control:** "Every change tracked in Git automatically"
2. **Parallel Development:** "6 developers working simultaneously without conflicts"
3. **Automated Deployments:** "No more manual change sets"
4. **Full Visibility:** "Management can see progress in real-time"
5. **Compliance:** "Complete audit trail for SOX/regulatory requirements"

---

## Talking Points

### For Technical Audiences
- "Built on Git, integrates with GitHub/GitLab/Bitbucket"
- "Supports branching strategies: GitFlow, trunk-based, etc."
- "REST API for CI/CD integration"
- "Conflict detection and resolution"

### For Business Audiences
- "Faster time to market - deploy in minutes, not days"
- "Reduced errors from manual deployments"
- "Better collaboration across teams"
- "Clear visibility into what's being deployed"

### For Compliance/Security
- "Complete audit trail: who, what, when"
- "Approval gates and code review workflows"
- "Rollback capabilities"
- "Integration with security scanning tools"

---

## Common Questions & Answers

**Q: Do we need developers who know Git?**
A: DevOps Center abstracts most Git complexity. Admins can use the UI without Git knowledge. Developers can use Git directly if they prefer.

**Q: What about our existing change set process?**
A: You can migrate gradually. DevOps Center and change sets can coexist during transition.

**Q: How long does setup take?**
A: Initial setup: 1-2 hours. Creating a project: 10-15 minutes. After that, it's faster than change sets.

**Q: Can we integrate with Jenkins/GitHub Actions?**
A: Yes! DevOps Center has APIs for CI/CD integration, plus built-in automation.

**Q: What if we don't have GitHub?**
A: Works with GitHub, GitLab, and Bitbucket. Free tiers are sufficient to start.

---

## Troubleshooting

### Can't connect repository
- Ensure you've authorized GitHub OAuth
- Check repository permissions (need write access)
- Verify repository isn't empty (push at least one commit)

### Work item won't link to branch
- Branch must exist in the repository
- Check spelling/capitalization
- Ensure you're in the correct project

### Can't deploy
- Verify org connections (Named Credentials)
- Check user has deployment permissions
- Review error logs in deployment history

---

## Resources

- **Full Demo Guide:** `.agents/artifacts/devops-center-demo-guide.md`
- **Salesforce Docs:** https://help.salesforce.com/s/articleView?id=sf.devops_center_overview.htm
- **Trailhead:** https://trailhead.salesforce.com/content/learn/modules/devops-center-quick-look
- **GitHub Repo:** https://github.com/Tarateatoe/salesforce-devops-demo

---

## Summary: What You've Built

✅ **Realistic demo environment** with 4 projects  
✅ **13 work items** across different stages  
✅ **Actual Git branches** with commits  
✅ **Sample metadata** ready to deploy  
✅ **End-to-end workflow** ready to demonstrate  

**Time to setup:** ~30 minutes  
**Demo duration:** 10-15 minutes  
**Reusability:** 100% - generic enough for any customer  

---

**Created:** 2026-05-19  
**Your GitHub:** https://github.com/Tarateatoe  
**Demo Repo:** https://github.com/Tarateatoe/salesforce-devops-demo
