# Auto Git Commit & Push Script for UEFA Match Clock
# -----------------------------------------------
# This script stages all changes, commits with a timestamped message, and pushes to GitHub.

# Move to the script's folder
Set-Location -Path $PSScriptRoot

# Verify we're in a Git repo
if (-not (Test-Path ".git")) {
    Write-Host "❌ No .git folder found here. Please run this inside your repository." -ForegroundColor Red
    exit 1
}

# Get current time for commit message
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Stage all changes
git add .

# Commit with a timestamp message
git commit -m "Automated update: $timestamp"

# Push to GitHub
git push

# Output confirmation
Write-Host "✅ Update pushed successfully at $timestamp" -ForegroundColor Green
