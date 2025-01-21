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

# Function to parse query string parameters from the URL
function Parse-QueryParams {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Url
    )

    $uri = [uri]$Url
    $queryParams = @{}

    if ($uri.Query) {
        $uri.Query.TrimStart('?').Split('&') | ForEach-Object {
            $key, $value = $_ -split '=', 2
            $queryParams[$key] = $value
        }
    }

    return $queryParams
}

# Get the URL of the script
$scriptUrl = $MyInvocation.MyCommand.Definition

# Fetch and parse query parameters from the URL
$queryParams = Parse-QueryParams -Url $scriptUrl

# Check if the 'Number' parameter is provided in the query string
if (-not $queryParams['Number']) {
    Write-Host "Error: A 'Number' parameter is required in the query string." -ForegroundColor Red
    Write-Host "Example usage:" -ForegroundColor Yellow
    Write-Host "iwr -useb 'https://raw.githubusercontent.com/YourUsername/CheckPrime/main/CheckPrime.ps1?Number=29' | iex"
    exit 1
}

# Ensure the provided 'Number' is a valid integer
$Number = [int]$queryParams['Number']
if ($null -eq $Number) {
    Write-Host "Error: Invalid 'Number' parameter. Please provide a valid integer." -ForegroundColor Red
    exit 1
}

# Check if the number is prime and output the result
if (Is-Prime -Number $Number) {
    Write-Host "The number $Number is a prime number." -ForegroundColor Green
} else {
    Write-Host "The number $Number is NOT a prime number." -ForegroundColor Red
}
