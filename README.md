Download the ZIP file by clicking on "Code" and "Download ZIP".

Please place the "MSGraph" folder into C:\User\*USERPROFILE*\ directory. This will be the directory you will work from. It may be best to pin this file path in your explorer.

If you are updating this folder with the latest version, please delete the MSGraph folder first before re-placing it.

The scripts will be blocked if you download them from here. Before running any scripts, please run the below command in PowerShell. This will only need to be run once, unless you download the files again.

``` Get-ChildItem "$env:USERPROFILE\MSGraph\Scripts" -Recurse | Unblock-File ```

To use any of the scripts, use the following example command in PowerShell.

``` & "C:\Users\*USERPROFILE*\MSGraph\Scripts\Intune\Android\DeleteDeviceUsingIMEI.ps1" ```

This will run the specific script you want.
