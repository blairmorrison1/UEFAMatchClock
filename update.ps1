# Auto Git Pull + Commit + Push Script for UEFA Match Clock
# ---------------------------------------------------------
# This script:
#   1. Pulls the latest changes from GitHub
#   2. Stages all local changes
#   3. Commits with a timestamp
#   4. Pushes updates back to GitHub

# Move to this script's directory
Set-Location -Path $PSScriptRoot

# Verify we're inside a Git repo
if (-not (Test-Path ".git")) {
    Write-Host "❌ No .git folder found here. Run this inside your repository." -ForegroundColor Red
    exit 1
}

# Optional: set your branch name (change if you're using something other than 'main')
$branch = "main"

Write-Host "🔄 Pulling latest changes from GitHub..." -ForegroundColor Cyan
git pull origin $branch

# Stage all local changes
Write-Host "🗂️  Staging all modified files..." -ForegroundColor Cyan
git add .

# Create a timestamped commit message
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$commitMessage = "Automated update: $timestamp"

# Commit if there are changes
$changes = git diff --cached --name-only
if (-not [string]::IsNullOrWhiteSpace($changes)) {
    git commit -m "$commitMessage"
    Write-Host "💾 Committed changes: $commitMessage" -ForegroundColor Yellow
} else {
    Write-Host "✅ No changes to commit." -ForegroundColor Green
}

# Push updates
Write-Host "🚀 Pushing updates to GitHub..." -ForegroundColor Cyan
git push origin $branch

Write-Host "✅ All done! Deployed at $timestamp" -ForegroundColor Green
