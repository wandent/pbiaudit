Connect-PowerBIServiceAccount
$lastendTimePath = "c:\temp\lastEndTime.txt"

try {
    $lastEndTimeString = Get-Content -Path $lastendTimePath  -ErrorAction SilentlyContinue    
    $startTime = (Get-date -Date $lastEndTimeString -format "yyyy-MM-ddTHH:mm:ss" )
    $endTime = (Get-Date -format "yyyy-MM-ddTHH:mm:ss")
    
    
} catch {
    write-host "No last endtime file found at $lastendTimePath"
    $endTime = (Get-Date -format "yyyy-MM-ddTHH:mm:ss")   
    #write-host $endtime     
    # Defaults starttime for the previous day
    $startTime = (get-date $endTime).AddDays(-1)
    #write-host (get-date $startTime -format "yyyy-MM-ddTHH:mm:ss")   
}
$startTimeString = Get-Date $starttime  -format "yyyy-MM-ddTHH:mm:ss" 
$endTimeString = Get-Date $endTime -format "yyyy-MM-ddTHH:mm:ss"


## Generates for all activities in Power BI auditiing, however it comes with the cost of performance
# $activities = Get-PowerBIActivityEvent -ActivityType "ViewReport" -StartDateTime $startTimeString -EndDateTime $endTimeString | ConvertFrom-Json
# $activities[0] | Export-CSV -Path c:\temp\PowerBIAPIAudit_$(Get-Date $startTime -Format yyyyMMdd_HH-mm).csv -Delimiter ";" -Encoding UTF8 


## complete list of event types : https://docs.microsoft.com/en-us/power-bi/admin/service-admin-auditing
# Activity Types
# ViewDashboard 
# ShareReport
# ShareDashboard
# RefreshDataset
# PrintReport
# EditReport
# DownloadReport
# CreateReport 
# CreateDataset
# DeleteDataset
# DeleteReport
# ExportReport
# Import
# AddFolderAccess

## Add to the list the types of events we want to capture

 $ActivityTypes = 'ViewDashboard','ShareReport','ShareDashboard','RefreshDataset'

 $horas = '00:00:00', '01:00:00', '23:59:59'

 ## loops through the events
 ## need to validate if the conversion from json and capturing the first levvel is working correctly. 

 $ActivityTypes | ForEach-Object  {
    write-host "Generando logs para: $_ "
    $activities = Get-PowerBIActivityEvent -ActivityType $_ -StartDateTime $startTimeString -EndDateTime $endTimeString | ConvertFrom-Json
    $activities[0] | Export-CSV -Path c:\temp\PowerBIAPIAudit_$(Get-Date $startTime -Format yyyyMMdd_HH-mm).csv -Delimiter ";" -Encoding UTF8 
     }

$endTimeString | Set-Content -Path $lastendTimePath -Force

Disconnect-PowerBIServiceAccount 