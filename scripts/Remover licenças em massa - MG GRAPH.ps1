$grupos = "AIDA-MDM-Level01","APAC-MDM-Level01","APAC-MDM-Level02","APAC-MDM-Level03","BR-MDM-Test","BR-MDM-BYOD-Level","BR-MDM-BYOD-Level","BR-MDM-CONSELHEIROS","BR-MDM-General","BR-MDM-Level01","BR-MDM-Level02","BR-MDM-Level03","BR-MDM-TREINAMENTO","EMEA-MDM-Level01","EMEA-MDM-Level02","EMEA-MDM-Level03","US-MDM-BYOD","US-MDM-Level01","US-MDM-Level02","US-MDM-Level03","WEB-O365-LICENSE-E1-BASIC","WEB-O365-LICENSE-E1-PRO","WEB-OFFICE-WEB","WEB-OFFICE-WEB-PHONE"

<#
$gruposID = "bc53c454-e0a9-4c09-81f5-bd1597bedbf8","425723bd-0793-4647-9cd2-008bc5c324b1","214509bb-8d7e-4100-a4eb-9421726e8fdb","5fccabfb-9c3c-4538-aca4-216ffac35e53","9713c4c9-3d39-4e15-9698-8d507e903c1a","85c65d5d-1529-4e07-88bc-fc347ee6ffa9","9713c4c9-3d39-4e15-9698-8d507e903c1a","85c65d5d-1529-4e07-88bc-fc347ee6ffa9","6d745e11-07cc-4d5e-bf16-0d4dd4520bfa","5d673276-9065-4640-8ece-855244b7ac0d","c8a26b78-9998-4c3c-91d7-31e686adb275","2b3d609f-54da-4aee-b887-b591efa1aea1","321e64bb-ce03-4d2d-998a-672a0d302d36","83f1a8c1-94cc-428b-a4f8-0e8e997998cd","b677e707-00b3-4b5e-a2b8-1e509def1399","b0792cd8-5df0-4d6b-bede-fd0c2351250f","32efcb56-e741-4df5-8859-f9699c49a47a","17dbc7e3-bf6c-4698-bff3-fb8b702a9746","6bf44ba9-51af-46a8-8b0d-2398fd2bd2f8","17cb502c-6a68-4ad1-8e81-623da1caf26c","d50abeb3-3874-491d-b9c0-0e546c7a234e","b320a93b-57fe-4d44-9ef2-942363b63ea1","56bf2173-1cc7-4e41-9850-4494ec647214","89eb504d-83ba-4373-8f6d-027cc00988b7","2b9ccd73-33fc-4267-a18a-7190ed48901a","2b9ccd73-33fc-4267-a18a-7190ed48901a"
#>

$DadosGrupo = @()
$gruposOBJ = $grupos | ForEach-Object {get-MgGroup -Filter "DisplayName eq '$_'"}

foreach ($grupoOBJ in $gruposOBJ) {
   #$membros = Get-AzureADGroupMember -objectid $grupoOBJ.ObjectID #| select userprincipalname
    $membros = Get-MgGroupMember -groupid $grupoOBJ | Select-Object @{n="Grupo displayName";e={$_.AdditionalProperties.displayName}}

$DadosGrupo += New-Object -TypeName PSObject -Property @{
    "Grupo" = (Get-MgGroup -GroupId $grupoOBJ).DisplayName
    "Membros" = $membros.'Grupo displayName' -join ";"
}
}
$DadosGrupo | export-csv c:\temp\MembrosGruposrelatorios3.csv -Encoding utf8 -Append -NoTypeInformation




    