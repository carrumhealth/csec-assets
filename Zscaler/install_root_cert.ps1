# Specify the URL where the Zscaler certificate is available
$certUrl = "https://raw.githubusercontent.com/carrumhealth/csec-assets/refs/heads/master/Zscaler/ZscalerRootCertificate-2048-SHA256.crt"

# Specify the desired path to save the certificate locally
$certPath = "C:\Temp\ZscalerRootCA.crt"

# Download the certificate
Write-Host "Downloading certificate..."
Invoke-WebRequest -Uri $certUrl -OutFile $certPath

# Check if the download was successful
if (-not Test-Path $certPath) {
  Write-Host "Error: Failed to download certificate."
  Exit 1
}

# Install the certificate
Write-Host "Installing certificate..."
certutil -addstore "ROOT" "$certPath"

# Check if the installation was successful
if ($LASTEXITCODE -eq 0) {
  Write-Host "Certificate installed successfully!"
} else {
  Write-Host "Error: Failed to install certificate."
  Write-Host "Error code: $($LASTEXITCODE)"
  Exit 1
}