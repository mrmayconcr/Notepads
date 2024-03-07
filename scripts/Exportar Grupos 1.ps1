<#.EXAMPLE
  Export-O365Groups -CSVFilename .\Groups.CSV
#>
param([parameter(Mandatory=$True, HelpMessage='Please enter a filename for the CSV file to export')]$CSVFilename)
 
Write-Host -ForegroundColor Green "Loading all Office 365 Groups"
$Groups = Get-AzureADGroup -All $true
 
# Process Groups
$GroupsCSV = @()
Write-Host -ForegroundColor Green "Processing Groups"
foreach ($Group in $Groups)
{
    # Get  members
    $Members = Get-AzureADGroupMember -ObjectId $Group.objectid  
    $MembersUNP=@()
    foreach ($Member in $Members)
    {
        $MembersUNP+=$Member.UserPrincipalName        
    }
    # Get  owners
    $Owners = Get-AzureADGroupOwner -ObjectId $Group.objectid 
    $OwnersUNP=@()
    foreach ($Owner in $Owners)
    {
        $OwnersUNP+=$Owner.UserPrincipalName
    }
    # Create CSV file line
    $GroupsRow =   [pscustomobject]@{
                    GroupObjectID = $Group.objectid
                    Members = $MembersUNP -join "`n"
                    Owners = $OwnersUNP -join "`n"
                    }
 
    # Add to export array
    $GroupsCSV+=$GroupsRow
}
 
# Export to CSV
Write-Host -ForegroundColor Green "`nCreating and exporting CSV file"
$GroupsCSV | Export-Csv -NoTypeInformation -Path $CSVFilename