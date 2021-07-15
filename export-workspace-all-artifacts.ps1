$scope = "Organization"
#$scope =  "Individual"

Connect-PowerBIServiceAccount
# only works with organization scope
Get-PowerBIWorkspace -Scope $scope -All -Include All| Export-CSV -Path "c:\temp\PBIServiceAssets-Workspaces_and_all_$(get-date -format yyyyMMdd_HH-mm).csv" -Delimiter ";" -Encoding UTF8 

Disconnect-PowerBIServiceAccount 