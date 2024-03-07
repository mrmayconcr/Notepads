

$sites = "https://embraer.sharepoint.com/sites/EVEStream-eVTOL","https://embraer.sharepoint.com/sites/DemoFlight","https://embraer.sharepoint.com/sites/UATMProductDevelopmentStrategy","https://embraer.sharepoint.com/sites/TalentManagement931","https://embraer.sharepoint.com/sites/CorporateStrategyMaterials","https://embraer.sharepoint.com/sites/Legal-INTERNO","https://embraer.sharepoint.com/sites/EVE-SafetySWSysDevelopmentCyberSEteam","https://embraer.sharepoint.com/sites/EVE-SafetySWSysDevelopmentCyberSEteam","https://embraer.sharepoint.com/sites/EVESBPwork","https://embraer.sharepoint.com/sites/PERSONAL-EDU","https://embraer.sharepoint.com/sites/EISPLANNING","https://embraer.sharepoint.com/sites/EVEIndustrialStrategy","https://embraer.sharepoint.com/sites/CorporateDevelopment","https://embraer.sharepoint.com/sites/ProgramsTeam","https://embraer.sharepoint.com/sites/DataStrategic","https://embraer.sharepoint.com/sites/RiskManagementInternalControls","https://embraer.sharepoint.com/sites/EveNoiseandVibrationTeam","https://embraer.sharepoint.com/sites/EveStrategicPlan447","https://embraer.sharepoint.com/sites/EVEHRTeam","https://embraer.sharepoint.com/sites/EVESTREAM-USECOSYSTEM","https://embraer.sharepoint.com/sites/AccountingTaxandTreasury","https://embraer.sharepoint.com/sites/EVEIT","https://embraer.sharepoint.com/sites/ESGSustainability","https://embraer.sharepoint.com/sites/Controladoria-EVE","https://embraer.sharepoint.com/sites/EveTeam-IndustrialDesign","https://embraer.sharepoint.com/sites/EveTeam-IndustrialDesign","https://embraer.sharepoint.com/sites/EngineeringProjectManagement","https://embraer.sharepoint.com/sites/EVEAIRMOBILITY-AIRWORTHINESS","https://embraer.sharepoint.com/sites/EveTeam-ElectricPropulsion2","https://embraer.sharepoint.com/sites/EVEManufacturingEngineeringTeam","https://embraer.sharepoint.com/sites/FinanceiroEVE","https://embraer.sharepoint.com/sites/CPESGEANDO","https://embraer.sharepoint.com/sites/data_analysis","https://embraer.sharepoint.com/sites/EmbraerX-EveProject-com","https://embraer.sharepoint.com/sites/FlightOps28","https://embraer.sharepoint.com/sites/InterioresSKY","https://embraer.sharepoint.com/sites/ExecutiveCareConnections","https://embraer.sharepoint.com/sites/ApresentaoEVEeUAML0Construction","https://embraer.sharepoint.com/sites/ExpertiseTeam","https://embraer.sharepoint.com/sites/UXcore","https://embraer.sharepoint.com/sites/UAMCompetitiveLandscape","https://embraer.sharepoint.com/sites/UATMShare","https://embraer.sharepoint.com/sites/HMITraining","https://embraer.sharepoint.com/sites/GovernanceChannel-MGT","https://embraer.sharepoint.com/sites/Designsystem385","https://embraer.sharepoint.com/sites/SafetyandProcessAssurance","https://embraer.sharepoint.com/sites/Techs4ESG","https://embraer.sharepoint.com/sites/eVTOLDIP","https://embraer.sharepoint.com/sites/EnterpriseRiskManagementERM","https://embraer.sharepoint.com/sites/HRCompensation","https://embraer.sharepoint.com/sites/EHSSJK","https://embraer.sharepoint.com/sites/TrainingProviderSelection","https://embraer.sharepoint.com/sites/UAMSAProject","https://embraer.sharepoint.com/sites/EVEFAQ61","https://embraer.sharepoint.com/sites/EveUATMCommercializationStrategy","https://embraer.sharepoint.com/sites/EVEEDO-InteriorConcept2","https://embraer.sharepoint.com/sites/CertificationBasisdiscussion","https://embraer.sharepoint.com/sites/EHS760","https://embraer.sharepoint.com/sites/LeasingStrategy","https://embraer.sharepoint.com/sites/ComponentLoads-RoadMap","https://embraer.sharepoint.com/sites/BRMarket-HelisulVolocopterEmbraerX","https://embraer.sharepoint.com/sites/NewEmbraerVSSTechCareLeadership","https://embraer.sharepoint.com/sites/EVEAeronautics","https://embraer.sharepoint.com/sites/VisibilidadeVagasVTE"

# Transformando em objetos
$SitesOBJ = $sites | ForEach-Object {Get-SPOSite -identity $_}   

# Definir o csv
$csvFilePath = ".\SharepointEVEarmazenamento04-03-24.csv"

function Export-CSVInfo {
    param(
        [string]$oldValue,
        [string]$newValue,
        [string]$siteName,
        [string]$siteUrl
    )
    $csvData = "$oldValue,$newValue,$siteName,$siteUrl"
    $csvData | Out-File -FilePath $csvFilePath -Append -Encoding utf8
}

# cotas dos sites
Write-Host "Iniciando ajustes de cotas de armazenamento..."

# Sites com armazenamento inferior a 50GB
$SitesOBJ | ForEach-Object {
    #$siteobjeto = get-sposite -Identity $_
    $oldQuota = $_.StorageQuota
    $siteName = $_.Title
    $siteUrl = $_.Url
    Write-Host "Atualizando site '$siteName' de cota '$oldQuota' para '312000'..."
    Set-SPOSite -Identity $_.Url -StorageQuota 312000 -StorageQuotaWarningLevel 280000 -Confirm:$false
    Export-CSVInfo -oldValue $oldQuota -newValue '312000' -siteName $siteName -siteUrl $siteUrl
}
