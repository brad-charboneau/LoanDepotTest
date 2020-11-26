<# 
.SYNOPSIS 
 Returns the first charater that is repeated in a string of arbitrary legnth
 
.DESCRIPTION 
 Returns the first charater that is repeated in a string of arbitrary legnth
 
.NOTES 
┌─────────────────────────────────────────────────────────────────────────────────────────────┐ 
│ ORIGIN STORY                                                                                │ 
├─────────────────────────────────────────────────────────────────────────────────────────────┤ 
│   DATE        : 2020.11.23 
│   AUTHOR      : Bradford Charboneau
│   DESCRIPTION : LoanDepot Powershell Test
└─────────────────────────────────────────────────────────────────────────────────────────────┘ 
 
.PARAMETER inputString 
        String To Look For First Repeated Character In

.EXAMPLE 
        Get-FirstRepeatingChar -inputString 'asdflkoijABCDader'
            Output: First Repeated Character found in "asdflkoijABCDader" was: "a" 
            Reason: Compairson is case sensitive, so it skips the "A" and returns the "a" that follows it.
#> 

# Returns the first charater that is repeated in a string of arbitrary legnth

function Get-FirstRepeatingChar() {
    [OutputType([String])]     
    [CmdletBinding()] 
    Param 
    ( 
        [Parameter(Mandatory = $true)] 
        [String]$inputString
    )
    # Convert String to array of Characters
    $charArray = $inputString.ToCharArray()

    # Create Hashtable to pass first occurrence characters into list for compare
    $charHashtable = @{}
    # Loop through array of characters
    $i = 0
    foreach ($char in $charArray) {
        Try {
            $charHashtable.Add($char, $i++) | Out-Null
        } 
        Catch [ArgumentException] {
            # If Character is found in the Hashtable already, Stop and return Character to Console Output
            return "First Repeated Character found in `"$inputString`" was: `"$char`""
        }
    }
    return "No Repeating Characters Found" 
}
