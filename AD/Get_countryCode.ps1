$userOUs = "OU=ExampleBranch,OU=Users,DC=example,DC=com"
$Users = $null

$userOUs | ForEach-Object { $Users += Get-ADUser -filter 'enabled -eq $true' -searchbase $_ -Properties countryCode | Sort-Object -Property Name }

foreach ($User in $Users) {
    Write-Host "$($User.Name) - $($User.countryCode)" -ForegroundColor Cyan
}