<#
.SYNOPSIS
    Set Interface Metric Ethernet adapter from automatic to a metric of 35
	Mark Messink 21-12-2021
	This script sets the adapter metric. When establishing a VPN connection, the VPN's automatic metric is 25.
	This solves the problem of using the VPN adapter with the on-premises DNS settings instead of the Ethernet adapters with the public DNS settings.
	

.DESCRIPTION
 Defaults:
 LAN = 25
 Ethernet = 50
 Wi-Fi = 55
 Mobile = 55
 Bluetooth = 65
 
.INPUTS
  None

.OUTPUTS
  Log file: pslog_Set-NIC-Metric.txt
  
.NOTES

.EXAMPLE
  .\ChangeMetricEthernetAdapter.ps1 

#>

# Prevent teminating script on error
$ErrorActionPreference = 'Continue'

# Aanmaken standaard logpath (als deze nog niet bestaat)
$path = "C:\IntuneLogs"
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}

$logPath = "$path\pslog_Set-NIC-Metric.txt"

#Start logging
Start-Transcript $logPath -Append -Force

#Start script timer
$scripttimer = [system.diagnostics.stopwatch]::StartNew()

	Write-Output "-------------------------------------------------------------------"
    Write-Output "List Network Adapters"
	Get-NetIPInterface | FT InterfaceAlias, InterfaceMetric
	Write-Output "-------------------------------------------------------------------"
	Write-Output "Change Metric" 
	Get-NetIPInterface LAN* | Set-NetIPInterface -InterFaceMetric 35
	# Get-NetIPInterface Ethernet* | Set-NetIPInterface -InterFaceMetric 50
	Get-NetIPInterface Wi-F* | Set-NetIPInterface -InterFaceMetric 40
	# Get-NetIPInterface Mobi* | Set-NetIPInterface -InterFaceMetric 55
	# Get-NetIPInterface Blue* | Set-NetIPInterface -InterFaceMetric 65
    Write-Output "-------------------------------------------------------------------"
	Write-Output "List Network Adapters"
	Get-NetIPInterface | FT InterfaceAlias, InterfaceMetric
	Write-Output "-------------------------------------------------------------------"

#Stop and display script timer
$scripttimer.Stop()
Write-Output "-------------------------------------------------------------------"
Write-Output "Script elapsed time in seconds:"
$scripttimer.elapsed.totalseconds
Write-Output "-------------------------------------------------------------------"

#Stop Logging
Stop-Transcript
