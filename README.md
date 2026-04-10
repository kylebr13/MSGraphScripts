Once you download the Zip file, please place the "MSGraph" folder into C:\User\*USERPROFILE*\ directory. This will be the directory you will work from.

If you are updating this folder with the latest version, please delete the MSGraph folder first before re-placing it.

Before running any scripts, please run the below command in PowerShell

Get-ChildItem "$env:USERPROFILE\MSGraph\Scripts" -Recurse | Unblock-File 

To run any of the commands, use when in PowerShell you will want to do for example - 

& "C:\Users\*USERPROFILE*\MSGraph\Scripts\Intune\Android\DeleteDeviceUsingIMEI.ps1"

This will allow the scripts to run.
