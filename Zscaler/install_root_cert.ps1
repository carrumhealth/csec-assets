$certUrl = "https://raw.githubusercontent.com/carrumhealth/csec-assets/refs/heads/master/Zscaler/ZscalerRootCertificate-2048-SHA256.crt"

$certPath = "C:\Temp\ZscalerRootCA.crt"

Write-Host "Downloading certificate..."
Invoke-WebRequest -Uri $certUrl -OutFile $certPath

if (-not Test-Path $certPath) {
  Write-Host "Error: Failed to download certificate."
  Exit 1
}

Write-Host "Installing certificate..."
certutil -addstore "ROOT" "$certPath"

if ($LASTEXITCODE -eq 0) {
  Write-Host "Certificate installed successfully!"
} else {
  Write-Host "Error: Failed to install certificate."
  Write-Host "Error code: $($LASTEXITCODE)"
  Exit 1
}
