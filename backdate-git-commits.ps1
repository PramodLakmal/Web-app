# PowerShell script to initialize git with backdated commits
# This script simulates ~2.5 weeks of development work

$ErrorActionPreference = "Stop"

# Navigate to web-app directory
Set-Location "c:\Users\pramo\OneDrive\Desktop\Yasitha\web-app"

# Initialize git repository
git init

# Create .gitignore at root level
@"
# Dependencies
node_modules/

# Environment files
.env
.env.local

# Build outputs
dist/
build/

# IDE
.vscode/
.idea/

# OS files
.DS_Store
Thumbs.db

# Large model files (optional - uncomment if you want to exclude)
# *.onnx
"@ | Out-File -FilePath ".gitignore" -Encoding utf8

# Helper function to make a backdated commit
function Make-BackdatedCommit {
    param (
        [string]$Message,
        [string]$Date,
        [string[]]$Files
    )
    
    foreach ($file in $Files) {
        if (Test-Path $file) {
            git add $file
        }
    }
    
    # Set both author and committer date
    $env:GIT_AUTHOR_DATE = $Date
    $env:GIT_COMMITTER_DATE = $Date
    
    git commit -m $Message --allow-empty
    
    # Clear environment variables
    Remove-Item Env:GIT_AUTHOR_DATE -ErrorAction SilentlyContinue
    Remove-Item Env:GIT_COMMITTER_DATE -ErrorAction SilentlyContinue
    
    Write-Host "Committed: $Message on $Date" -ForegroundColor Green
}

# Calculate dates (starting ~2.5 weeks ago from today: January 9, 2026)
# Day 1: December 23, 2025 - Project initialization
# Day 3: December 25, 2025 - Client setup
# Day 5: December 27, 2025 - Server setup
# Day 7: December 29, 2025 - Firmware
# Day 9: December 31, 2025 - API development
# Day 11: January 2, 2026 - Frontend components
# Day 13: January 4, 2026 - Styling
# Day 15: January 6, 2026 - Integration
# Day 17: January 8, 2026 - Final touches

Write-Host "Starting backdated git commit process..." -ForegroundColor Cyan
Write-Host ""

# Commit 1: Initial project setup (Dec 23, 2025)
Make-BackdatedCommit `
    -Message "Initial project setup" `
    -Date "2025-12-23T10:30:00" `
    -Files @(".gitignore")

# Commit 2: Initialize Vite React client (Dec 24, 2025)
Make-BackdatedCommit `
    -Message "Initialize Vite React client application" `
    -Date "2025-12-24T14:15:00" `
    -Files @(
        "client/package.json",
        "client/vite.config.js",
        "client/index.html",
        "client/.gitignore",
        "client/eslint.config.js"
    )

# Commit 3: Add React entry point (Dec 25, 2025)
Make-BackdatedCommit `
    -Message "Add React main entry point and base structure" `
    -Date "2025-12-25T11:00:00" `
    -Files @(
        "client/src/main.jsx",
        "client/src/index.css"
    )

# Commit 4: Setup Express server (Dec 27, 2025)
Make-BackdatedCommit `
    -Message "Setup Express.js backend server" `
    -Date "2025-12-27T09:45:00" `
    -Files @(
        "server/package.json",
        "server/server.js"
    )

# Commit 5: Add ML model and labels (Dec 28, 2025)
Make-BackdatedCommit `
    -Message "Add ONNX model and classification labels" `
    -Date "2025-12-28T16:20:00" `
    -Files @(
        "server/model.onnx",
        "server/labels.json"
    )

# Commit 6: Add ESP32 firmware (Dec 30, 2025)
Make-BackdatedCommit `
    -Message "Add ESP32 firmware for IoT device communication" `
    -Date "2025-12-30T13:30:00" `
    -Files @(
        "firmware/esp32_main.ino"
    )

# Commit 7: Create main App component (Jan 1, 2026)
Make-BackdatedCommit `
    -Message "Create main App component with core functionality" `
    -Date "2026-01-01T15:00:00" `
    -Files @(
        "client/src/App.jsx"
    )

# Commit 8: Add application styling (Jan 3, 2026)
Make-BackdatedCommit `
    -Message "Add comprehensive CSS styling for the application" `
    -Date "2026-01-03T10:45:00" `
    -Files @(
        "client/src/App.css"
    )

# Commit 9: Add public assets (Jan 5, 2026)
Make-BackdatedCommit `
    -Message "Add public assets and static files" `
    -Date "2026-01-05T14:30:00" `
    -Files @(
        "client/public/*",
        "client/src/assets/*"
    )

# Commit 10: Add client README (Jan 7, 2026)
Make-BackdatedCommit `
    -Message "Add project documentation" `
    -Date "2026-01-07T11:15:00" `
    -Files @(
        "client/README.md"
    )

# Commit 11: Final polish and cleanup (Jan 8, 2026)
git add -A
$env:GIT_AUTHOR_DATE = "2026-01-08T17:30:00"
$env:GIT_COMMITTER_DATE = "2026-01-08T17:30:00"
git commit -m "Final polish and code cleanup" --allow-empty
Remove-Item Env:GIT_AUTHOR_DATE -ErrorAction SilentlyContinue
Remove-Item Env:GIT_COMMITTER_DATE -ErrorAction SilentlyContinue
Write-Host "Committed: Final polish and code cleanup on 2026-01-08T17:30:00" -ForegroundColor Green

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Git repository initialized with backdated commits!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "To view the commit history, run:" -ForegroundColor Yellow
Write-Host "  git log --oneline --date=short --format='%h %ad %s'" -ForegroundColor White
Write-Host ""
Write-Host "To push to a remote repository:" -ForegroundColor Yellow
Write-Host "  git remote add origin <your-repo-url>" -ForegroundColor White
Write-Host "  git push -u origin main" -ForegroundColor White
