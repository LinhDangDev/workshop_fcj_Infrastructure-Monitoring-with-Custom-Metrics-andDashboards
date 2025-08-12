# PowerShell script to fix image paths for GitHub Pages deployment
# This script replaces /images/ with the full GitHub Pages path

$contentPath = "./content"
$oldPattern = "/images/"
$newPattern = "/workshop_fcj_Infrastructure-Monitoring-with-Custom-Metrics-andDashboards/images/"

Write-Host "Fixing image paths in markdown files..."

# Get all .md files in content directory recursively
$mdFiles = Get-ChildItem -Path $contentPath -Recurse -Filter "*.md"

foreach ($file in $mdFiles) {
    $content = Get-Content $file.FullName -Raw
    if ($content -match [regex]::Escape($oldPattern)) {
        Write-Host "Fixing paths in: $($file.FullName)"
        $newContent = $content -replace [regex]::Escape($oldPattern), $newPattern
        Set-Content -Path $file.FullName -Value $newContent -NoNewline
    }
}

Write-Host "Image path fixing completed!"
