$secpwd = ConvertTo-SecureString -String "Mudar123@" -AsPlainText -Force
Import-Module ADDSDeployment
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "WinThreshold" `
-DomainName "new.local" `
-DomainNetbiosName "NEW" `
-ForestMode "WinThreshold" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-SysvolPath "C:\Windows\SYSVOL" `
-SafeModeAdministratorPassword $secpwd `
-Force:$true

Start-Sleep 120