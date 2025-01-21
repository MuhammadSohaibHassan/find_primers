# Function to check if a number is prime
function Is-Prime {
    param (
        [Parameter(Mandatory = $true)]
        [int]$Number = 29  # Default number is hardcoded as 29
    )

    if ($Number -le 1) {
        return $false
    }
    if ($Number -eq 2) {
        return $true
    }
    if ($Number % 2 -eq 0) {
        return $false
    }
    $limit = [math]::Sqrt($Number)
    for ($i = 3; $i -le $limit; $i += 2) {
        if ($Number % $i -eq 0) {
            return $false
        }
    }

    return $true
}

# Check if the 'Number' argument is provided
$Number = 29  # Hardcoded to 29

# Check if the number is prime and output the result
if (Is-Prime -Number $Number) {
    Write-Host "The number $Number is a prime number." -ForegroundColor Green
} else {
    Write-Host "The number $Number is NOT a prime number." -ForegroundColor Red
}
