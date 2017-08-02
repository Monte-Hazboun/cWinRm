Function Get-Targetresource {
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$Transport, 

        [Parameter(Mandatory = $true)]
        [String]$port,

        [Parameter()]
        [String]$Address = '*',

        [Parameter()]
        [ValidateSet("Present", "Absent")]
        [String]$Ensure
    )


    $winrmdata = winrm e winrm/config/listener
    $winrmObject = Convert-WinRMDataToObject $winrmdata

    $listener = $winrmObject | where { ($_.transport -eq $Transport) -and ($_.port -eq $port) -and ($_.Address -eq $address) }
    $presence = if ($listener) {"Present"} else {"Absent"}

    return @{
        Transport = $Transport
        Port      = $port
        Address   = $Address
        Ensure    = $presence
    }
}


Function Test-Targetresource {
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$Transport, 

        [Parameter(Mandatory = $true)]
        [String]$port,

        [Parameter()]
        [String]$Address = '*',

        [Parameter()]
        [ValidateSet("Present", "Absent")]
        [String]$Ensure
    )


    $winrmdata = winrm e winrm/config/listener
    $winrmObject = Convert-WinRMDataToObject $winrmdata

    $listener = $winrmObject | where { ($_.transport -eq $Transport) -and ($_.port -eq $port) -and ($_.Address -eq $Address) } 
    switch ($Ensure) {
        "Present" {
            if ($listener) {
                return $true  
            } else {
                return $false
            }
        }
        "Absent" {
            if ($listener) {
                return $false 
            } else {
                return $true
            }
        }
    }
}

Function Set-Targetresource {
    param (
        [Parameter(Mandatory = $true)]
        [ValidateSet("HTTP","HTTPs",IgnoreCase=$true)]
        [String]$Transport, 

        [Parameter(Mandatory = $true)]
        [String]$port,

        [Parameter()]
        [String]$Address = '*',

        [Parameter()]
        [ValidateSet("Present", "Absent")]
        [String]$Ensure
    )


    switch ($ensure) {
        "Present" {
            if ($Transport -eq "HTTP") {
                if ($port -eq "80") {
                    $exp = "`@`{EnableCompatibilityHttpListener=`"true`"`}"
                    winrm set winrm/config/service $exp    
                } else {
                    winrm quickconfig -q
                    winrm delete winrm/config/listener?Address=$address+Transport=$transport
                    winrm create winrm/config/listener?Address=$address+Transport=$transport        
                }    
            }
            if ($transport -eq "HTTPs") {
                winrm quickconfig -transport:https -q    
            }
        }
        "Absent" {
            if ($port -eq 80) {
                $exp = "`@`{EnableCompatibilityHttpListener=`"false`"`}"
                winrm set winrm/config/service $exp    
            } else {
                winrm delete winrm/config/listener?Address=$address+Transport=$transport        
            }    
         }
     }
}

Function Convert-WinRMDataToObject {
    param (
        [string[]]$winrmdata
    )

    $winRMarray = @()

    foreach ($line in $winrmdata) {
        if ($line -like "Listener*") {
            $object = New-Object -TypeName psobject -Property @{
                Name = $line
                Address = ""
                Transport = ""
                Port = ""
                Enabled = ""
                URLPrefix = ""
                ListeningOn = ""
            }
            continue
        }
        
        if ($line -like "*Hostname*" -or $line -like "*CertificateThumbprint*") {continue}
        if ($line -eq "") {
            $winRMarray+=$object
        } else {
            $linesplit = $line.Split("=").TrimStart("    ")
            $name = $linesplit[0].replace(" ","")
            $value = $linesplit[1].replace(" ","")
            $object.$name = $value
        }              
    
    }
    return $winRMarray
}

Export-ModuleMember *-TargetResource