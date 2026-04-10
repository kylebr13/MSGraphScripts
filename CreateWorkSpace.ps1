#Creates Folder Structure Required
New-Item -Path "$env:USERPROFILE\MSGraph\" -ItemType Directory
New-Item -Path "$env:USERPROFILE\MSGraph\CSV" -ItemType Directory
New-Item -Path "$env:USERPROFILE\MSGraph\CSV\Intune" -ItemType Directory
New-Item -Path "$env:USERPROFILE\MSGraph\CSV\Intune\Import\" -ItemType Directory
New-Item -Path "$env:USERPROFILE\MSGraph\CSV\Intune\Export\" -ItemType Directory

#Creates default files within folders
New-Item -Path "$env:USERPROFILE\MSGraph\CSV\Intune\Import\AndroidSerialNumber.csv" -ItemType File
New-Item -Path "$env:USERPROFILE\MSGraph\CSV\Intune\Import\AndroidIMEI.csv" -ItemType File

#Creates headers for CSV's
"IMEI" | Set-Content "$env:USERPROFILE\MSGraph\CSV\Intune\Import\AndroidIMEI.csv" -Encoding UTF8
"SerialNumber" | Set-Content "$env:USERPROFILE\MSGraph\CSV\Intune\Import\AndroidSerialNumber.csv" -Encoding UTF8