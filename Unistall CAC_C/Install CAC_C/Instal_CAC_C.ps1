# Define the list of folder names to move
$folderNames = @(
    "BEX_Affinities",
    "BiggerDrops",
    "BTSimpleMechAssembly",
    "BTX_CAC_Compatibility",
    "BT_Extended",
    "BT_Extended_Timeline",
    "CustomActivatableEquipment",
    "CustomAmmoCategories",
    "CustomComponents",
    "CustomLocalization",
    "CustomLocalSettings",
    "CustomPrewarm",
    "CustomUnits",
    "CustomVoices",
    "FullXotlTables",
    "IRBTModUtils",
    "IRTweaks",
    "LICENSE",
    "MechAffinity",
    "MissionControl",
    "ModTek",
    "RaidFix",
    "README.md"
)

# Get the current directory
$baseDirectory = Get-Location

# Prompt for the target path
$TargetPath = Read-Host "Enter the target path"

# Ensure the target path is not null or empty
if ([string]::IsNullOrWhiteSpace($TargetPath)) {
    Write-Error "Target path cannot be null or empty."
    exit 1
}

# Ensure the target path exists
if (-not (Test-Path -Path $TargetPath)) {
    try {
        New-Item -ItemType Directory -Path $TargetPath -ErrorAction Stop
        Write-Output "Created target directory: $TargetPath"
    } catch {
        Write-Error "Failed to create target directory: $_"
        exit 1
    }
}

# Initialize progress variables
$totalFolders = $folderNames.Count
$currentFolder = 0

# Loop through each folder name and move it
foreach ($folderName in $folderNames) {
    $sourcePath = Join-Path -Path $baseDirectory -ChildPath $folderName
    $destinationPath = Join-Path -Path $TargetPath -ChildPath $folderName

    # Update the progress bar
    $currentFolder++
    $percentComplete = ($currentFolder / $totalFolders) * 100
    Write-Progress -Activity "Moving folders" -Status "Processing $folderName" -PercentComplete $percentComplete

    # Check if the source path exists before attempting to move it
    if (Test-Path -Path $sourcePath) {
        # If destination exists, remove it to handle overwriting
        if (Test-Path -Path $destinationPath) {
            Remove-Item -Path $destinationPath -Recurse -Force
            Write-Output "Removed existing: $destinationPath"
        }
        
        # Move the folder
        Move-Item -Path $sourcePath -Destination $destinationPath -Force
        Write-Output "Moved: $sourcePath to $destinationPath"
    } else {
        Write-Output "Source path does not exist: $sourcePath"
    }
}

# Final progress update
Write-Progress -Activity "Moving folders" -Status "Completed" -PercentComplete 100 -Completed
Write-Output "All folders have been moved successfully."
