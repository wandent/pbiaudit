$scope = "Organization"
#$scope =  "Individual"

Connect-PowerBIServiceAccount
$datetimestring =  (get-date -format yyyyMMdd_HH-mm) 

<# Collect all of the Reports across the tenant and append the WorkspaceID they belong to. #>

 foreach ($Workspace in Get-PowerBIWorkspace -Scope $scope -All )
 {
     $Dashboard = Get-PowerBIDashboard -WorkspaceId ($Workspace.Id) -Scope $scope
     $Dashboard | Add-Member -NotePropertyName WorkspaceId -NotePropertyValue $Workspace.Id;
     $Dashboard |    Export-CSV -Path "c:\temp\PBIServiceAssets-Dashboards_$($datetimestring).CSV"-Delimiter ";" -Encoding UTF8 -Append
 }

# Get-PowerBIDashboard -Scope $scope | export-csv -path "c:\temp\PBIServiceAssets-Dashboards_$(Get-Date -format yyyyMMdd_HH-mm).CSV" -Delimiter ";" -Encoding UTF8

Disconnect-PowerBIServiceAccount 