$secpwd= ConvertTo-SecureString -String "Mudar123@" -AsPlainText -Force
$UserAccount = Get-LocalUser -Name "Administrator"
$UserAccount | Set-LocalUser -Password $secpwd