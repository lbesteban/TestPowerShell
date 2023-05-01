function check_dns($server,$lookup,$correct_result){
    try{
        $dns=(Resolve-DnsName -Name $lookup -Server $server -TcpOnly -Type A -NoHostsFile -ErrorAction Stop)
        $addr=$dns.IPAddress
        if( $addr -contains $correct_result){
            Write-Output "INFO: [$server] is OK" # comment out if you want to focus on eithre lying or misconfigured/dumb dns servers
        } else {Write-Output "ERROR VALUE: DNS Server [$server] thinks $lookup IP is [$addr] instead of [$correct_result]"}
        
    }
    catch{ 
        $err_msg=$Error[0].ToString()
        # Fails too often, $server_name=([system.net.dns]::GetHostByAddress($server)).HostName
        # Write-Output "ERROR: DNS Server [$server] - [$server_name] $err_msg"
        Write-Output "ERROR: DNS Server [$server] $err_msg"
        }
}

$dnslist =@(8.8.8.8,1.1.1.1)

$dnslist | %{ check_dns $_ parler.com resolver1.opendns.com}
