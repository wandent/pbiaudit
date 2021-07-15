$scope = "Organization"
#$scope =  "Individual"
Connect-PowerBIServiceAccount

$datetimestring =  (get-date -format yyyyMMdd_HH-mm) 



<# Collect all of the Reports across the tenant and append the WorkspaceID they belong to. #>

 foreach ($Workspace in Get-PowerBIWorkspace -Scope Organization -All ) 
 {
     $Report = Get-PowerBIReport -WorkspaceId ($Workspace.Id) -Scope Organization
     $Report | Add-Member -NotePropertyName WorkspaceId -NotePropertyValue $Workspace.Id;
     $Report | Export-CSV -Path "c:\temp\PBIServiceAssets-Reports_$($datetimestring).CSV" -Delimiter ";" -Encoding UTF8 -Append
 }

 Disconnect-PowerBIServiceAccount 