### Variables
# Example user OU path
$userOUs = "OU=ExampleBranch,OU=Users,DC=example,DC=com"
# Example USA countryCode
$corrCountryCode = 840
$Users = $null
$fixedUser = $null

# $Users = All enabled user from example user OU with countryCode property
$userOUs | ForEach-Object { $Users += Get-ADUser -filter 'enabled -eq $true' -searchbase $_ -Properties countryCode }

# Check every user
foreach ($User in $Users) {
    if ($User.countryCode -eq $corrCountryCode) {
        # Output users with correct countryCode
        Write-Host "$($User.Name) - Correct countryCode!" -ForegroundColor Green
    } else {
        # Output users with wrong countryCode, replace current value with value from $corrCountryCode
        Write-Host "$($User.Name) - Wrong countryCode!" -ForegroundColor Red
        $User | Set-ADUser -Replace @{countryCode="$($corrCountryCode)"}
        $fixedUser++
    }
}

# Output number of fixed users
Write-Host "Number of fixed users: " -NoNewline
$fixedUser