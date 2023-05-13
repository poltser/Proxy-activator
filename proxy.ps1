function Set-Proxy ( $server,$port)
{
    $path = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings'
    $value = "ProxyEnable"
    $working = (Get-ItemProperty -Path $path -Name $value).$value
    If ($working -eq "1"){
    Set-ItemProperty -Path $path -name ProxyEnable 0
    }
    Else{
        If ((Test-NetConnection -ComputerName $server -Port $port).TcpTestSucceeded) {
        Set-ItemProperty -Path $path -name ProxyServer -Value "$($server):$($port)"
        Set-ItemProperty -Path $path -name ProxyEnable -Value 1
        }
        Else {
        Write-Error -Message "Can't connect to the proxy-server°:  $($server):$($port)"
        }
    }
}

Set-Proxy 188.120.245.151 9999
