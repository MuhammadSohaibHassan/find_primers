# Function to check if a number is prime
function Is-Prime {
    param (
        [int]$Number
    )

    if ($Number -lt 2) {
        return $false
    }
    for ($i = 2; $i -le [math]::Sqrt($Number); $i++) {
        if ($Number % $i -eq 0) {
            return $false
        }
    }
    return $true
}

# Parse query parameters from the script URL
$scriptUrl = $MyInvocation.MyCommand.Definition
$parsedUrl = [uri]$scriptUrl
$queryParams = $parsedUrl.Query -split "&" | ForEach-Object {
    $kvp = $_ -split "="
    @{$kvp[0] = $kvp[1]}
}

# Extract the 'Number' parameter from query
$Number = $queryParams["Number"]

# Ensure the Number is provided and valid
if (-not $Number -or -not ($Number -as [int])) {
    Write-Host "Error: A valid integer 'Number' parameter is required in the query string." -ForegroundColor Red
    Write-Host "Example usage:" -ForegroundColor Yellow
    Write-Host "iwr -useb 'https://raw.githubusercontent.com/YourUsername/CheckPrime/main/CheckPrime.ps1?Number=29' | iex"
    exit 1
}

# Convert the number to an integer and check if it's prime
$Number = [int]$Number
if (Is-Prime -Number $Number) {
    Write-Host "The number $Number is a prime number." -ForegroundColor Green
} else {
    Write-Host "The number $Number is NOT a prime number." -ForegroundColor Red
}
