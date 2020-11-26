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

.PARAMETER CaseSensitive
        Allows user to specify if Search should Consider Case Sensitivity
        Default: False

.OUTPUTS
        System.String of first repeated character
        if CaseSensitive Switch is NOT used:
            if "asdflkoijABCDader" is passed to Get-FirstRepeatingChar Function, then A is returned as lowercase a is the same as Capital A because case is ignored
            if "asdflkoijABCDider" is passed to Get-FirstRepeatingChar Function, then A is returned as lowercase a is the same as Capital A because case is ignored
        if CaseSensitive Switch is used:
            if "asdflkoijABCDader" is passed to Get-FirstRepeatingChar Function, then a is returned because case must also match
            if "asdflkoijABCDider" is passed to Get-FirstRepeatingChar Function, then i is returned because case must also match

.EXAMPLE 
        Get-FirstRepeatingChar -inputString 'asdflkoijABCDader'
            First Repeated Character found in "asdflkoijABCDader" was: "A"
.EXAMPLE
        Get-FirstRepeatingChar 'asdflkoijader'
            First Repeated Character found in "asdflkoijABCDider" was: "A"
.EXAMPLE 
        Get-FirstRepeatingChar -inputString 'asdflkoijABCDader' -CaseSensitive
            First Repeated Character found in "asdflkoijABCDader" was: "a"
.EXAMPLE
        Get-FirstRepeatingChar 'asdflkoijABCDider' -CaseSensitive
            First Repeated Character found in "asdflkoijABCDider" was: "i"
#> 

# Returns the first charater that is repeated in a string of arbitrary legnth

function Get-FirstRepeatingChar() {
    [OutputType([String])]     
    [CmdletBinding()] 
    Param 
    ( 
        [Parameter(Mandatory = $true)] 
        [String]$inputString,

        [Parameter()]
        [Switch]$CaseSensitive = $false
    )
    # Convert String to array of Characters
    $charArray = $inputString.ToCharArray()

    # Create Hashtable to pass first occurrence characters into list for compare
    $charHashtable = @{}
    # Loop through array of characters
    $i = 0
    foreach ($char in $charArray) {
        Try { 
            if($CaseSensitive) {
                $charHashtable.Add($char, $i++) | Out-Null
            } else {
                $charHashtable.Add($char.ToLower(), $i++) | Out-Null
            }
        } Catch [ArgumentException] {
            # If Character is found in the Hashtable already, Stop and return Character to Console Output
            return "First Repeated Character found in `"$inputString`" was: `"$char`""
        }
    }
    return "No Repeating Characters Found" 
}
