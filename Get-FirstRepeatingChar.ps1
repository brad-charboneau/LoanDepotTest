<# 
.SYNOPSIS 
 Returns the first charater that is repeated in a string of arbitrary legnth
 
.DESCRIPTION 
 LoanDepot DevOps Interview Powershell Test:
 Create a powershell function or cmdlet that takes an arbitrarily long string parameter 
 $foo (e.g. 'abcdedcba') and returns the first recurring character in that Input string. 
 In 'abcdedcba', 'd' would be the first recurring character, so the cmdlet/function should 
 return 'd' for that sample input.  Be mindful of the runtime of your solution."
 
.NOTES 
┌─────────────────────────────────────────────────────────────────────────────────────────────┐ 
│ ORIGIN STORY                                                                                │ 
├─────────────────────────────────────────────────────────────────────────────────────────────┤ 
│   DATE        : 2020.11.23 
│   AUTHOR      : Bradford Charboneau
│   DESCRIPTION : LoanDepot DevOps Powershell Test
└─────────────────────────────────────────────────────────────────────────────────────────────┘ 
 
.PARAMETER inputString 
        String To Look For First Repeated Character In
.EXAMPLE 
        Get-FirstRepeatingChar -inputString 'asdflkoijABCDader'
            Output: First Repeated Character found in "asdflkoijABCDader" was: "a" 
            Reason: Compairson is case sensitive, so it skips the "A" and returns the "a" that follows it.
            
.EXAMPLE 
        'asdflkoijABCDader','zxcvbnb'|Get-FirstRepeatingChar 
            Output: 
                First Repeated Character found in "asdflkoijABCDader" was: "a" 
                First Repeated Character found in "zxcvbnb" was: "b"
#> 

# Returns the first charater that is repeated in a string of arbitrary legnth

function Get-FirstRepeatingChar() {
    [OutputType([String])]     
    [CmdletBinding()] 
    Param 
    ( 
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ValueFromPipeline = $true
        )] 
        [String]$inputString
    )
    BEGIN {
        # Initialize Variables
        $charHashtable = @{}
        $i = 0
    }
    PROCESS {
        # if multiple strings were passed via pipeline, Clear Hashtable on subsequent runs
        If ($charHashtable.Count -ne 0) {
            $charHashtable.Clear()
        }
        # Convert String to array of Characters
        $charArray = $inputString.ToCharArray()
        foreach ($char in $charArray) {
            Try {
                $charHashtable.Add($char, $i++) | Out-Null
            } 
            Catch [ArgumentException] {
                # If Character is found in the Hashtable already, Stop and return Character to Console Output
                return "First Repeated Character found in `"$inputString`" was: `"$char`""
            }
        }
        return "No Repeating Characters Found in `"$inputString`"" 
    }
}
