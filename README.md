# adfs-vm
Windows VM with partial ADFS setup using Vagrant

## Dependencies
- Virtualbox (https://www.virtualbox.org/wiki/Downloads)
- Vagrant (https://developer.hashicorp.com/vagrant/install?product_intent=vagrant)

## Installation

This `Vagrantfile` uses the [`vagrant-reload`](https://github.com/aidanns/vagrant-reload) plugin to reboot the Windows VM's during provisioning. If you don't have this plugin installed, do it now with

```bash
vagrant plugin install vagrant-reload
```

This config setup machine to ip address `192.168.56.2`, adapt address according to your vm network.

To build vm, use `vagrant up adfs-vm`.

After machine is ready to use, some configuration is needed:

1. Login on vm using vagrant credentials
- Username: vagrant
- Password: vagrant

2. Open Powershell terminal as administrator
3. Execute command to install certificate (warning should be ignored):
```
mkdir c:\vagrant\certs
cd c:\vagrant\certs
mkcert -install
mkcert -pkcs12 *.new.local
mv .\_wildcard.new.local.p12 .\_wildcard.new.local.pfx
```
4. Open IIS manager
5. Click on server, and then, select `Server Certificates`
![Screenshot of IIS certificate setup](/assets/iis-certificate-setup.png)
6. Click on `Import...`
![Screenshot to enter import certificate configuration](/assets/import-certificate.png)
7. Select the previously generated pfx file with password `changeit`
![Screenshot to certificate configuration values](/assets/configure-certificate.png)
8. Select Default Web Site on IIS and click in `Bindings...`
![Screenshot to configure https on IIS site](/assets/setup-https.png)
9. Click in `Add...`
10. Configure as image below, using the password `changeit`:
![Screenshot with https site binding options](/assets/setup-https-2.png)
11. Ignore warning alert.
12. Execute command bellow to promote vm to domain controller:
```
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
```
13. After automatic reboot, run the following command on powershell (with administrative rights):
```
C:\vagrant\scripts\install-adfs.ps1
```
14. Run following command to configure ADFS:
```
C:\vagrant\scripts\configure-adfs.ps1
```
15. When credentials are requested, pass the following values:
- Username: NEW\Administrator
- Password: Mudar123@
16. Restart server
17. After restart and all services starts, ADFS will be available for use