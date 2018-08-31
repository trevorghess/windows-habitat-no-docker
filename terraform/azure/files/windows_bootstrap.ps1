Write-Host "First, make sure WinRM can't be connected to"
netsh advfirewall firewall set rule name="Windows Remote Management (HTTP-In)" new enable=yes action=block

Write-Host "set administrator password"
cmd.exe /c net user Administrator FL0@T43BTnPK

Write-Host "Delete any existing WinRM listeners"
winrm delete winrm/config/listener?Address=*+Transport=HTTP  2>$Null
winrm delete winrm/config/listener?Address=*+Transport=HTTPS 2>$Null

Write-Host "Create a new WinRM listener and configure"
winrm create winrm/config/listener?Address=*+Transport=HTTP
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="0"}'
winrm set winrm/config '@{MaxTimeoutms="7200000"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service '@{MaxConcurrentOperationsPerUser="12000"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/client/auth '@{Basic="true"}'

Write-Host "Configure UAC to allow privilege elevation in remote shells"
$Key = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
$Setting = 'LocalAccountTokenFilterPolicy'
Set-ItemProperty -Path $Key -Name $Setting -Value 1 -Force

Write-Host "turn off PowerShell execution policy restrictions"
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine

Write-Host "Mount windows ISO and copy install dir"
Mount-DiskImage -ImagePath 'C:\Users\hab\Windows_Server_2016_Datacenter_EVAL_en-us_14393_refresh.ISO'
Copy-Item f:\sources\sxs\microsoft-windows-netfx3-ondemand-package.cab c:\sxs

Write-Host "Set Chrome as Default Browser"
$Browser_http_key = 'HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice'
$Browser_https_key = 'HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice'
Set-ItemProperty -Path $Browser_http_key -Name ProgId -Value ChromeHTML
Set-ItemProperty -Path $Browser_https_key -Name ProgId -Value ChromeHTML

Write-Host "Set VSC Settings"
$VSC_Settings_Dir = "$home/AppData/Roaming/Code/User"
New-Item $VSC_Settings_Dir -Type Directory
touch $VSC_Settings_Dir/settings.json
$VSC_Content = @{
    "update.channel" = "none"
    "telemetry.enableCrashReporter" = 'false'
    "telemetry.enableTelemetry" = 'false'
    "workbench.colorTheme" = "Solarized Light"
    "workbench.startupEditor" = "none"
}
$VSC_Content | ConvertTo-Json | Set-Content  -Path "$VSC_Settings_Dir/settings.json"


Write-Host "Configure and restart the WinRM Service; Enable the required firewall exception"
Stop-Service -Name WinRM
Set-Service -Name WinRM -StartupType Automatic
netsh advfirewall firewall set rule name="Windows Remote Management (HTTP-In)" new action=allow localip=any remoteip=any
Start-Service -Name WinRM

Write-Host "Create a hab user and add them to the admin group"
cmd.exe /c net user hab n0t@r34lp@ssword! /add /LOGONPASSWORDCHG:NO
cmd.exe /c net localgroup Administrators /add hab
cmd.exe /c wmic useraccount where "name='hab'" set PasswordExpires=FALSE
