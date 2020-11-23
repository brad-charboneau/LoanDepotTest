# Returns the first charater that is repeated in a string of arbitrary legnth

function Get-FirstRepeatingChar() {
    [OutputType([String])]     
    [CmdletBinding()] 
    Param 
    ( 
        [Parameter(Mandatory = $true)] 
        [String]$inputString
    )
    #convert String to array of Characters
    $charArray = $inputString.ToCharArray()

    #Create Object to pass first occurrence characters into list for compare
    $charObject = [System.Collections.ArrayList]@()
    
    #loop through array of characters
    foreach ($char in $charArray) {
        if ($char -notin $charObject) {
            # Insert Character into Object if it is not already there
            $charObject.Add($char) | Out-Null
        } else {
            # If Character is found in the Object already, Stop and return Current Character to Console Output
            return $char
        }
    }
}
