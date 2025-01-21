# Get the current working directory
$currentDir = Get-Location

# Get the length of the current directory path
$length = $currentDir.Path.Length

# Print the length
Write-Host "The length of the current working directory is: $length characters"
