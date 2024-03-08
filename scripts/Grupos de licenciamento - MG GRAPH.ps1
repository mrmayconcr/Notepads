$UsersData = @()
#$UsersExchange = get-recipient -recipientPreviewFilter "((Department -like '*DPS*') -and (ExtensionAttribute4 -eq 'Contractor'))" | select DisplayName, isDirSynced, primarysmtpaddress, recipientType, Manager, ExtensionAttribute1, ExtensionAttribute2, ExtensionAttribute3, ExtensionAttribute4, ExtensionAttribute5, ExtensionAttribute6, ExtensionAttribute7, ExtensionAttribute8, ExtensionAttribute9
#$UsersExchange = Get-User -ResultSize Unlimited -SortBy DisplayName
$UsersMG = Get-MgBetaUser -All -Filter "UserType eq 'Member'"
$UsersMG | Foreach-Object {
     #$GroupMembersMG = Get-MgBetaUserMemberOf -UserId $_.Id -Property Id,DisplayName,UserPrincipalName | Where-Object {$_.AdditionalProperties.'@odata.type' -eq "#microsoft.graph.group" -and $_.AdditionalProperties.displayName -like 'web-office*'} | Select-Object @{n="Grupo displayName";e={$_.AdditionalProperties.DisplayName}},id
     $GroupMembersMG = Get-MgBetaUserMemberOf -UserId $_.Id | Where-Object {$_.AdditionalProperties.'@odata.type' -eq "#microsoft.graph.group" -and $_.AdditionalProperties.displayName -like 'web-office*'} | Select-Object @{n="Grupo displayName";e={$_.AdditionalProperties.displayName}},id
     $UsersExtensionAttribute = $_.OnPremisesExtensionAttributes
 
     $UsersData += New-Object -TypeName PSObject -Property @{
         DisplayName = $_.DisplayName
         IsDirSynced = $_.OnPremisesSyncEnabled
         PrimarySmtpAddress = $_.UserPrincipalName
         RecipientType = $_.UserType
         #'Reporta para' = (get-recipient -Identity $_.Manager).WindowsLiveID
         ExtensionAttribute1 = $UsersExtensionAttribute.ExtensionAttribute1
         ExtensionAttribute2 = $UsersExtensionAttribute.ExtensionAttribute2
         ExtensionAttribute3 = $UsersExtensionAttribute.ExtensionAttribute3
         ExtensionAttribute4 = $UsersExtensionAttribute.ExtensionAttribute4
         ExtensionAttribute5 = $UsersExtensionAttribute.ExtensionAttribute5
         ExtensionAttribute6 = $UsersExtensionAttribute.ExtensionAttribute6
         ExtensionAttribute7 = $UsersExtensionAttribute.ExtensionAttribute7
         ExtensionAttribute8 = $UsersExtensionAttribute.ExtensionAttribute8
         ExtensionAttribute9 = $UsersExtensionAttribute.ExtensionAttribute9
         GrupoDisplayName = $GroupMembersMG.'Grupo displayName' -join "; "
         GrupoId = $GroupMembersMG.Id -join "; "
 
     }
}
 
$UsersData | Export-Csv .\RelatorioGruposLicenciamentoV4.csv -NoTypeInformation