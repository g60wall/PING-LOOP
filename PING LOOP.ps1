$Count = 5800
$Ping = @(tnc)
$Computer = "192.25.25.2";
While ($Count -gt 0)
{   $Ping += Get-WmiObject Win32_PingStatus -Filter "Address = '$Computer'" | Select @{Label="TimeStamp";Expression={Get-Date}},@{Label="Source";Expression={ $_.__Server }},@{Label="Destination";Expression={ $_.Address }},IPv4Address,@{Label="Status";Expression={ If ($_.StatusCode -ne 0) {"Failed"} Else {""}}},ResponseTime
    $Count --
    Start-Sleep -Seconds 30
}
$Ping | Select TimeStamp,Source,Destination,IPv4Address,Status,ResponseTime | ft -AutoSize
$Ping | Select TimeStamp,Source,Destination,IPv4Address,Status,ResponseTime | Export-CSV \\nas\it\james\ACTIVANTLOG.csv -NoTypeInformation