$GroupData = @()
$Groups = Get-DistributionGroup -ResultSize 50 -SortBy Name
$Groups | Foreach-Object {
   	
    $GroupMembers = Get-DistributionGroupMember -Identity $_.Identity | Select DisplayName, PrimarySmtpAddress
	
    $GroupData += New-Object -TypeName PSObject -Property @{
       
         GroupName = $_.Alias
         GroupDisplayName = $_.DisplayName
         GroupEmail = $_.PrimarySmtpAddress
         MemberName = $GroupMembers.DisplayName -join "; "
         MemberEmail = $GroupMembers.PrimarySmtpAddress -join "; "
        
    }
}

$GroupData | Export-Csv .\butico2.csv -NoTypeInformation