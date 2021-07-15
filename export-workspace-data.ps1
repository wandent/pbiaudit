$scope = "Organization"
#$scope =  "Individual"

Connect-PowerBIServiceAccount

Get-PowerBIWorkspace -Scope $scope -All | Export-CSV -Path "c:\temp\PBIServiceAssets-Workspaces_$(get-date -format yyyyMMdd_HH-mm).csv" -Delimiter ";" -Encoding UTF8 

Disconnect-PowerBIServiceAccount 