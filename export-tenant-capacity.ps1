$scope = "Organization"
#$scope =  "Individual"
Connect-PowerBIServiceAccount

Get-PowerBICapacity -Scope $scope | Export-Csv -Path "c:\temp\PBIServiceAssets-Capacity_$(get-date -format yyyyMMdd_HH-mm).CSV" -Delimiter ";" -Encoding UTF8 


Disconnect-PowerBIServiceAccount 