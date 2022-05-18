function New-RandomPassword {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [int]
        $Length = 16,
        [Parameter(Mandatory = $false)]
        [char[]]
        $disallowedCharacters
        # [char]39 is '
        # string array also works I.E @('*', ',', '?', '%', "'")
    )

    begin {
        # defines Random class
        $rnd = [System.Random]::new()
        # defines StringBuilder class
        $strBldr = [System.Text.StringBuilder]::new()
    }

    process {
        # generates random password
        foreach ($int in 1..$Length) {
            [void]$strBldr.Append(([char]$rnd.Next(33, 126)))
        }

        # save password to variable
        $res = $strBldr.ToString()

        # iterate through password string and generate new random for each disallowed character
        $disallowedCharacters.foreach({
            while ($res.Contains($_)) {
                $res = $res.Replace($_, [char]$rnd.Next(33, 126))
            }
        })
    }

    end {
        return $res.ToString()
    }
}
