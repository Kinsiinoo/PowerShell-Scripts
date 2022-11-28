$userOUs = "OU=ExampleBranch,OU=Users,DC=example,DC=com"
$corrCountryCode = 840
$Users = $null
$fixedUser = $null

$userOUs | ForEach-Object { $Users += Get-ADUser -filter 'enabled -eq $true' -searchbase $_ -Properties countryCode }

foreach ($User in $Users) {
    if ($User.countryCode -eq $corrCountryCode) {
        Write-Host "$($User.Name) - Correct countryCode!" -ForegroundColor Green
    } else {
        Write-Host "$($User.Name) - Wrong countryCode!" -ForegroundColor Red
        $User | Set-ADUser -Replace @{countryCode="$($corrCountryCode)"}
        $fixedUser++
    }
}

Write-Host "Number of fixed users: " -NoNewline
$fixedUser