#Import devices from a CSV. The CSV should have "SerialNumber" as the header
$import = Import-Csv "$env:USERPROFILE\MSGraph\CSV\Intune\Import\AndroidSerialNumber.csv"

#Goes through list and adds them to a variable called "Serial"
$results = foreach ($entry in $import) {

    #Trims "Serial" to remove the header
    $serial = $entry.SerialNumber.Trim()
    #Removes blank spaces
    if ([string]::IsNullOrWhiteSpace($serial)) { continue }

    #Gets device details and adds it to a variable called "intuneDevices"
    $intuneDevices = Get-MgDeviceManagementManagedDevice -Filter "serialNumber eq '$serial'"

    #Goes through intuneDevices
    foreach ($d in $intuneDevices) {

        #Adds device details to object which gets inputted into results variable
        [PSCustomObject]@{
            DeviceName          = $d.DeviceName
            ManagedDeviceId     = $d.Id
            OS                  = $d.OperatingSystem
            Serial              = $d.SerialNumber
            Model               = $d.Model
            LastCheckinTime     = $d.LastSyncDateTime
            Users               = $d.UserDisplayName
        }
    }
}

#Exports results into csv
$results | Export-Csv "$env:USERPROFILE\MSGraph\CSV\Intune\Export\IntuneDetections.csv" -NoTypeInformation -Force