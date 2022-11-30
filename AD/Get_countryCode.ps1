### Variables
# Example user OU path
$userOUs = "OU=ExampleBranch,OU=Users,DC=example,DC=com"
$Users = $null

# $Users = All enabled user from example user OU with countryCode property, sort by Name
$userOUs | ForEach-Object { $Users += Get-ADUser -filter 'enabled -eq $true' -searchbase $_ -Properties countryCode | Sort-Object -Property Name }

# Check every user
foreach ($User in $Users) {
    # Output users + countryCode
    Write-Host "$($User.Name) - $($User.countryCode)" -ForegroundColor Cyan
}