Write-Host("Exporting Configuration Data...")

if (!$Credentials) {$Credentials = Get-Credential}
if (!$conn) {$conn = Connect-CrmOnline -Credential $Credentials -ServerUrl $global:ServerUrl}

Write-Host "Generating data package"
$packages = Get-CrmDataPackage -Conn $conn -Fetches @("<fetch>
  <entity name='theme'>
    <attribute name='themeid' />
    <attribute name='name' />
    <attribute name='type' />
    <attribute name='isdefaulttheme' />
    <order attribute='name' descending='false' />
    <filter type='and'>
      <condition attribute='name' operator='eq' value='CRM Blue Theme' />
    </filter>
  </entity>
</fetch>") -DisablePluginsGlobally $true #`
#|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("")

$packages.Data.InnerXml | Out-File -FilePath  ..\..\ReferenceData\data.xml
$packages.Schema.InnerXml | Out-File -FilePath ..\..\ReferenceData\data_schema.xml



