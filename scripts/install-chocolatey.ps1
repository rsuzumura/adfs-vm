try { iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')) }
catch {
    Write-Host "An error occurred on chocolatey install"
}
