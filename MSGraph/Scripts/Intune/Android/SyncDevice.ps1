# Import devices from a CSV.
$devices = Import-Csv "$env:USERPROFILE\MSGraph\CSV\Intune\Import\AndroidDeviceName.csv"

# Goes through list and adds them to a variable called "DeviceName"
$results = foreach ($entry in $devices) {

    # Trims "IMEI" to remove the header
    $DeviceName = $entry.DeviceName.Trim()
    # Removes blank spaces
    if ([string]::IsNullOrWhiteSpace($DeviceName)) { continue }

    # Gets device details and adds it to a variable called "intuneDevices"
    $intuneDevices = Get-MgDeviceManagementManagedDevice -Filter "deviceName eq '$DeviceName' and operatingSystem eq 'Android'"

    # Goes through intuneDevices
    foreach ($d in $intuneDevices) {
        
        # Syncs device in Intune using DeviceName.
        Sync-MgDeviceManagementManagedDevice -ManagedDeviceId $d.Id -ErrorAction SilentlyContinue #-

        # Adds device details to object which gets inputted into results variable
        [PSCustomObject]@{
            DeviceName        = $d.DeviceName
            ManagedDeviceId   = $d.Id
            OS                = $d.OperatingSystem
            Serial            = $d.SerialNumber
            Model             = $d.Model
            SyncedInIntune    = "Yes"
            IMEI              = $d.IMEI
        }
    }
}

# Exports results into csv
$results | Export-Csv "$env:USERPROFILE\MSGraph\CSV\Intune\Export\IntuneSyncResults.csv" -NoTypeInformation