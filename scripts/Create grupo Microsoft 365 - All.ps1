#Parameters
$CSVFilePath = "C:\Temp\Bulk-DL.csv"
 
Try {
    #Connect to Exchange Online
    Connect-ExchangeOnline -ShowBanner:$False
 
    #Get Data from CSV and Create Distribution List
    Import-CSV $CSVFilePath | ForEach {
        New-DistributionGroup -Name $_.Name -PrimarySmtpAddress $_.Email -Type $_.Type -Members $_.Members.split(",")
        Write-host -f Green "Created Distribution List:"$_.Name
    }
}
Catch {
    write-host -f Red "Error:" $_.Exception.Message
}


#Read more: https://www.sharepointdiary.com/2022/02/office-365-create-distribution-list-using-powershell.html#ixzz81t4Za6yS