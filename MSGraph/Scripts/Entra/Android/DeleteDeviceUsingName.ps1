# Import devices
$csv = Import-Csv "$env:USERPROFILE\MSGraph\CSV\Intune\Import\AndroidDeviceId.csv"

# Adds list to variable called $csv
$results = foreach ($entry in $csv) {

    # Trims header and adds data to deviceId
    $deviceId = $entry.deviceId.Trim()

    # Removes blank sapce
    if ([string]::IsNullOrWhiteSpace($deviceId)) { continue }

    # Gets device details and adds it to a variable called "entraDevices"
    $entraDevices = Get-MgDevice -Filter "deviceId eq '$deviceId'"

    #Goes through Entra Devices
    foreach ($d in $entraDevices) {

        #Deletes device from Entra
        Remove-MgDevice -DeviceId $d.Id -WhatIf

        # Adds device details to object which gets inputted into results variable
        [PSCustomObject]@{
            DeviceName       = $d.DisplayName
            EntraObjectId    = $d.Id
            DeviceId         = $d.DeviceId
            OperatingSystem  = $d.OperatingSystem
            DeletedFromEntra = "Yes"

        }
    }
}

# Exports results into csv
$results | Export-Csv "$env:USERPROFILE\MSGraph\CSV\Intune\Export\EntraIDDeletions.csv" -NoTypeInformation