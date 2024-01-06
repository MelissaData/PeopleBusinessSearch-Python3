# Name:    PeopleBusinessSearchCloudAPI
# Purpose: Execute the PeopleBusinessSearchCloudAPI program

######################### Parameters ##########################
param(
    $maxrecords = '',
    $matchlevel = '',
    $addressline1 = '',
    $locality = '',
    $administrativearea = '',
    $postal = '',
    $anyname = '',
    $license = '', 
    [switch]$quiet = $false
    )

########################## Main ############################
Write-Host "`n===================== Melissa People Business Search Cloud API ========================`n"

# Get license (either from parameters or user input)
if ([string]::IsNullOrEmpty($license) ) {
  $license = Read-Host "Please enter your license string"
}

# Check for License from Environment Variables 
if ([string]::IsNullOrEmpty($license) ) {
  $license = $env:MD_LICENSE
}

if ([string]::IsNullOrEmpty($license)) {
  Write-Host "`nLicense String is invalid!"
  Exit
}

# Run project
if ([string]::IsNullOrEmpty($maxrecords) -and [string]::IsNullOrEmpty($matchlevel) -and [string]::IsNullOrEmpty($addressline1) -and [string]::IsNullOrEmpty($locality) -and [string]::IsNullOrEmpty($administrativearea) -and [string]::IsNullOrEmpty($postal) -and [string]::IsNullOrEmpty($anyname)) {
  python3 PeopleBusinessSearchPython3.py --license $license 
}
else {
  python3 PeopleBusinessSearchPython3.py --license $license --maxrecords $maxrecords --matchlevel $matchlevel --addressline1 $addressline1 --locality $locality --administrativearea $administrativearea --postal $postal --anyname $anyname
}
