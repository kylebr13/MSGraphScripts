# Import devices from a CSV. The CSV should have "SerialNumber" as the header
$devices = Import-Csv "C:\MSGraph\CSV\Intune\Import\IMEI.csv"

# Goes through list and adds them to a variable called "Serial"
$results = foreach ($entry in $devices) {

    # Trims "Serial" to remove the header
    $IMEI = $entry.IMEI.Trim()
    # Removes blank spaces
    if ([string]::IsNullOrWhiteSpace($IMEI)) { continue }

    # Gets device details and adds it to a variable called "intuneDevices"
    $intuneDevices = Get-MgDeviceManagementManagedDevice -Filter "imei eq '$IMEI'"

    # Goes through intuneDevices
    foreach ($d in $intuneDevices) {
        
        # Removed device from Intune using "Id". If you wish to test this without removing any devices, uncomment -WhatIf
        Remove-MgDeviceManagementManagedDevice -ManagedDeviceId $d.Id -ErrorAction SilentlyContinue #-WhatIf

        $i++
        Write-Progress -Activity "Processing Devices" -Status "Processing $i of $total" -PercentComplete (($i / $total) * 100)

        # Adds device details to object which gets inputted into results variable
        [PSCustomObject]@{
            DeviceName        = $d.DeviceName
            ManagedDeviceId   = $d.Id
            OS                = $d.OperatingSystem
            Serial            = $d.SerialNumber
            Model             = $d.Model
            DeletedFromIntune = "Yes"
            IMEI              = $d.IMEI
        }
    }
}

# Exports results into csv
$results | Export-Csv "C:\MSGraph\CSV\Intune\Export\IntuneDeletions.csv" -NoTypeInformation