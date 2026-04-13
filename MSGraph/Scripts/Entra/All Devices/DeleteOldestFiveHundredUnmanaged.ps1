# Get Entra User Registered Devices
$AllStaleEnraDevices = Get-MgDevice -All | Where-Object {
    $_.TrustType -eq "Workplace" -and                              # Entra registered only
    ($_.DeviceOwnership -ne "Company") -and                        # Exclude company-owned
    $_.ApproximateLastSignInDateTime -le (Get-Date).AddDays(-90)   # 90+ days inactive
} | Sort-Object ApproximateLastSignInDateTime
 
 
# Select  -first xxx earliest last sign-in date
$ToBeDeletedStaleEntraDevices = $AllStaleEnraDevices | Select-Object -First 500
 
 
# Open in GridView to Confirm
$ToBeDeletedStaleEntraDevices | Out-GridView -Title "To Be Deleted Stale Entra Devices"
 

# Delete Devices - Remove -WhatIf after testin
foreach ($Device in $TobeDeletedStaleEntraDevices) { Remove-MgDevice -DeviceId $Device.Id }