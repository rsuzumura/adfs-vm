#
# Windows PowerShell script for AD FS Deployment
#

Import-Module ADFS

# Get the credential used for performaing installation/configuration of ADFS
$installationCredential = Get-Credential -Message "Enter the credential for the account used to perform the configuration."

# Get the credential used for the federation service account
$serviceAccountCredential = Get-Credential -Message "Enter the credential for the Federation Service Account."

Install-AdfsFarm `
-CertificateThumbprint:"4EC8E5D350FFFB2C8D94302FDB6EA25170B62FB5" `
-Credential:$installationCredential `
-FederationServiceDisplayName:"ADFS Test" `
-FederationServiceName:"sso.new.local" `
-ServiceAccountCredential:$serviceAccountCredential