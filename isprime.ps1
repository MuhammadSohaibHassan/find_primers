# Function to check if a number is prime
function Is-Prime {
    param (
        [Parameter(Mandatory = $true)]
        [int]$Number
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

# Check if the 'Number' parameter is provided
if ($args.Length -eq 0) {
    Write-Host "Error: A 'Number' parameter is required." -ForegroundColor Red
    Write-Host "Usage: iwr -useb 'https://raw.githubusercontent.com/YourUsername/CheckPrime/main/CheckPrime.ps1' | iex -ArgumentList 29"
    exit 1
}

# Get the 'Number' from the command argument
$Number = [int]$args[0]

# Check if the number is prime and output the result
if (Is-Prime -Number $Number) {
    Write-Host "The number $Number is a prime number." -ForegroundColor Green
} else {
    Write-Host "The number $Number is NOT a prime number." -ForegroundColor Red
}
