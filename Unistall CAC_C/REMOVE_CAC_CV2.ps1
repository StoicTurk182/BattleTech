# Define the list of folder names to remove
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
    ".modTek",
    "RaidFix",
    "README.md"
)

# Get the current directory
$baseDirectory = Get-Location

# Loop through each folder name and remove it
foreach ($folderName in $folderNames) {
    $fullPath = Join-Path -Path $baseDirectory -ChildPath $folderName
    
    # Check if the path exists before attempting to remove it
    if (Test-Path -Path $fullPath) {
        # Remove the folder
        Remove-Item -Path $fullPath -Recurse -Force
        Write-Output "Removed: $fullPath"
    } else {
        Write-Output "Path does not exist: $fullPath"
    }
}
