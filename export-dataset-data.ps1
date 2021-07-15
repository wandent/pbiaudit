$scope = "Organization"
#$scope =  "Individual"
Login-PowerBIServiceAccount

$datetimestring =  (get-date -format yyyyMMdd_HH-mm) 
# Collect all of the Datasets across the tenant and append the WorkspaceID they belong to. #>
 foreach ($Workspace in Get-PowerBIWorkspace -Scope $scope -All) 
 {
     $Dataset = Get-PowerBIDataset -WorkspaceId $Workspace.Id -Scope $scope 
     $Dataset | Add-Member -NotePropertyName WorkspaceId -NotePropertyValue $Workspace.Id;
     $Dataset | Export-CSV -Path "c:\temp\PBIServiceAssets-Datasets_$($datetimestring).CSV" -Delimiter ";" -Encoding UTF8 -Append
 }

 Disconnect-PowerBIServiceAccount 