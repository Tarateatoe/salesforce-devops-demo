#!/bin/bash
# Push Salesforce DevOps Center Demo to GitHub
# Username: Tarateatoe

set -e

echo "🚀 Pushing Salesforce DevOps Center Demo to GitHub"
echo "===================================================="
echo ""
echo "📋 Repository contains:"
echo "  • 1 main branch (production)"
echo "  • 4 project branches"
echo "  • 6 feature branches with realistic commits"
echo "  • Sample Salesforce metadata"
echo ""

# Check if GitHub repo exists
read -p "Have you created the GitHub repo 'salesforce-devops-demo' yet? (y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo ""
    echo "Please create it first:"
    echo "1. Go to: https://github.com/new"
    echo "2. Repository name: salesforce-devops-demo"
    echo "3. Description: Salesforce DevOps Center demo with realistic projects and work items"
    echo "4. Make it: Public or Private (your choice)"
    echo "5. DO NOT initialize with README, .gitignore, or license"
    echo "6. Click 'Create repository'"
    echo ""
    echo "Then run this script again!"
    exit 0
fi

echo ""
echo "✅ Great! Now pushing to GitHub..."
echo ""

# Add remote
git remote add origin https://github.com/Tarateatoe/salesforce-devops-demo.git || echo "Remote already exists"

# Push main branch
echo "📤 Pushing main branch..."
git push -u origin main

# Push all project branches
echo "📤 Pushing project branches..."
git push origin project/customer-portal
git push origin project/sales-optimization
git push origin project/service-modernization
git push origin project/marketing-automation

# Push all feature branches
echo "📤 Pushing feature branches..."
git push origin feature/enhanced-case-form
git push origin feature/kb-integration
git push origin feature/sso-auth
git push origin feature/auto-followup-flow
git push origin feature/risk-assessment-lwc
git push origin feature/lead-scoring-model

echo ""
echo "===================================================="
echo "✅ Successfully pushed to GitHub!"
echo ""
echo "📍 Repository URL:"
echo "   https://github.com/Tarateatoe/salesforce-devops-demo"
echo ""
echo "🎯 Next Steps:"
echo ""
echo "1. Open DevOps Center in your Salesforce org"
echo "2. Click 'Connect Repository'"
echo "3. Select GitHub"
echo "4. Authorize and select 'salesforce-devops-demo'"
echo "5. Follow the demo guide to create projects and work items"
echo ""
echo "📖 Demo Guide Location:"
echo "   ~/claude-projects/sf-demo-scout/.agents/artifacts/devops-center-demo-guide.md"
echo ""
echo "Happy demoing! 🎉"
echo ""
