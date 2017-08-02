Function Get-Targetresource {
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$SettingName, 

        [Parameter(Mandatory = $true)]
        [String]$SettingValue,

        [Parameter()]
        [ValidateSet("Present", "Absent")]
        [String]$Ensure
    )


    $winrmdata = winrm get winrm/config/service
    $winrmObject = Convert-WinRMDataToObject $winrmdata

    switch ($SettingName) {
        "CredSSP"           { $presence = if ($winrmObject.Auth.$settingname -eq $SettingValue) {"Present"} else {"Absent"} }
        "Kerberos"          { $presence = if ($winrmObject.Auth.$settingname -eq $SettingValue) {"Present"} else {"Absent"} }
        "Negotiate"         { $presence = if ($winrmObject.Auth.$settingname -eq $SettingValue) {"Present"} else {"Absent"} }
        "Basic"             { $presence = if ($winrmObject.Auth.$settingname -eq $SettingValue) {"Present"} else {"Absent"} }
        "cbthardeninglevel" { $presence = if ($winrmObject.Auth.$settingname -eq $SettingValue) {"Present"} else {"Absent"} }
        "Certificate"       { $presence = if ($winrmObject.Auth.$settingname -eq $SettingValue) {"Present"} else {"Absent"} }
        "HTTP"              { $presence = if ($winrmObject.DefaultPorts.$settingname -eq $SettingValue) {"Present"} else {"Absent"} }
        "HTTPS"             { $presence = if ($winrmObject.DefaultPorts.$settingname -eq $SettingValue) {"Present"} else {"Absent"} }
        default             { $presence = if ($winrmObject.$settingname -eq $SettingValue) {"Present"} else {"Absent"} }
    }

    return @{
        SettingName  = $SettingName
        SettingValue = $SettingValue
        Ensure       = $presence
    }
}


Function Test-Targetresource {
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$SettingName, 

        [Parameter(Mandatory = $true)]
        [String]$SettingValue,

        [Parameter()]
        [ValidateSet("Present", "Absent")]
        [String]$Ensure
    )


    $winrmdata = winrm g winrm/config/service
    $winrmObject = Convert-WinRMDataToObject $winrmdata

    switch ($SettingName) {
        "CredSSP"           { if ($winrmObject.Auth.$settingname -eq $SettingValue) {return $true} else {return $false} }
        "Kerberos"          { if ($winrmObject.Auth.$settingname -eq $SettingValue) {return $true} else {return $false} }
        "Negotiate"         { if ($winrmObject.Auth.$settingname -eq $SettingValue) {return $true} else {return $false} }
        "Basic"             { if ($winrmObject.Auth.$settingname -eq $SettingValue) {return $true} else {return $false} }
        "cbthardeninglevel" { if ($winrmObject.Auth.$settingname -eq $SettingValue) {return $true} else {return $false} }
        "Certificate"       { if ($winrmObject.Auth.$settingname -eq $SettingValue) {return $true} else {return $false} }
        "HTTP"              { if ($winrmObject.DefaultPorts.$settingname -eq $SettingValue) {return $true} else {return $false} }
        "HTTPS"             { if ($winrmObject.DefaultPorts.$settingname -eq $SettingValue) {return $true} else {return $false} }
        default             { if ($winrmObject.$settingname -eq $SettingValue) {return $true} else {return $false} }
    }
}

Function Set-Targetresource {
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$SettingName, 

        [Parameter(Mandatory = $true)]
        [String]$SettingValue,

        [Parameter()]
        [ValidateSet("Present", "Absent")]
        [String]$Ensure
    )


    switch ($ensure) {
        "Present" {
                switch ($SettingName) {
                    "CredSSP"           { $runme = "`@`{$SettingName=`"$SettingValue`"`}"
                                          winrm set winrm/config/service/auth $runme # | Out-Null                                      
                    }
                    "Kerberos"          { $runme = "`@`{$SettingName=`"$SettingValue`"`}"
                                          winrm set winrm/config/service/auth $runme # | Out-Null                                       
                    }
                    "Negotiate"         { $runme = "`@`{$SettingName=`"$SettingValue`"`}"
                                          winrm set winrm/config/service/auth $runme # | Out-Null                                     
                    }
                    "Basic"             { $runme = "`@`{$SettingName=`"$SettingValue`"`}"
                                          winrm set winrm/config/service/auth $runme # | Out-Null                    
                    }
                    "cbthardeninglevel" { $runme = "`@`{$SettingName=`"$SettingValue`"`}"
                                          winrm set winrm/config/service/auth $runme # | Out-Null                                        
                    }
                    "Certificate"       { $runme = "`@`{$SettingName=`"$SettingValue`"`}"
                                          winrm set winrm/config/service/auth $runme # | Out-Null                            
                    }
                    "HTTP"              { $runme = "`@`{$SettingName=`"$SettingValue`"`}"
                                          winrm set winrm/config/service/DefaultPorts $runme # | Out-Null
                    }
                    "HTTPS"             { $runme = "`@`{$SettingName=`"$SettingValue`"`}"
                                          winrm set winrm/config/service/DefaultPorts $runme # | Out-Null           
                    }
                    default             { $runme = "`@`{$SettingName=`"$SettingValue`"`}"
                                          winrm set winrm/config/service $runme # | Out-Null
                    }
                }

        }
        "Absent" {
                switch ($SettingName) {
                    "CredSSP"           { $runme = "`@`{$SettingName=`"`"`}"
                                          winrm set winrm/config/service/auth $runme # | Out-Null                                      
                    }
                    "Kerberos"          { $runme = "`@`{$SettingName=`"`"`}"
                                          winrm set winrm/config/service/auth $runme # | Out-Null                                       
                    }
                    "Negotiate"         { $runme = "`@`{$SettingName=`"`"`}"
                                          winrm set winrm/config/service/auth $runme # | Out-Null                                     
                    }
                    "Basic"             { $runme = "`@`{$SettingName=`"`"`}"
                                          winrm set winrm/config/service/auth $runme # | Out-Null                    
                    }
                    "cbthardeninglevel" { $runme = "`@`{$SettingName=`"`"`}"
                                          winrm set winrm/config/service/auth $runme # | Out-Null                                        
                    }
                    "Certificate"       { $runme = "`@`{$SettingName=`"`"`}"
                                          winrm set winrm/config/service/auth $runme # | Out-Null                            
                    }
                    "HTTP"              { $runme = "`@`{$SettingName=`"`"`}"
                                          winrm set winrm/config/service/DefaultPorts $runme # | Out-Null
                    }
                    "HTTPS"             { $runme = "`@`{$SettingName=`"`"`}"
                                          winrm set winrm/config/service/DefaultPorts $runme # | Out-Null           
                    }
                    default             { $runme = "`@`{$SettingName=`"`"`}"
                                          winrm set winrm/config/service $runme # | Out-Null
                    }
                }   
         }
     }
}

Function Convert-WinRMDataToObject {
    param (
        [string[]]$winrmdata
    )

    $object = New-Object -TypeName psobject -Property @{
        RootSDDL = ""
        MaxConcurrentOperations = ""
        MaxConcurrentOperationsPerUser = ""
        EnumerationTimeoutms = ""
        MaxConnections = ""
        MaxPacketRetrievalTimeSeconds = ""
        AllowUnencrypted = ""
        Auth = @{
            Basic = ""
            Kerberos = ""
            Negotiate = ""
            Certificate = ""
            CredSSP = ""
            cbthardeninglevel = ""
        }
        DefaultPorts = @{
            HTTP = ""
            HTTPS = ""
        }
        IPv4Filter = ""
        IPv6Filter = ""
        EnableCompatibilityHttpListener = ""
        EnableCompatibilityHttpsListener = ""
        AllowRemoteAccess = ""
    }

    $propertyNames = ($object | Get-Member -MemberType NoteProperty).Name
          
    foreach ($line in $winrmdata) {
        $linesplit = $line.Split("=").TrimStart("    ")
        if ($linesplit.count -gt 1) {
            $name = $linesplit[0].replace(" ","")
            $value = $linesplit[1].replace(" [Source","").replace(" ","")
        }

        if ($propertyNames -contains $name) {
            $object.$name = $value
        } else {
            if ($object.Auth.Keys -contains $name) {
                $object.Auth.$name = $value
            }
            if ($object.DefaultPorts.Keys -contains $name) {
                $object.DefaultPorts.$name = $value
            }
        } 
    }            
    return $object
}

Export-ModuleMember *-TargetResource