# Première chose à faire, obtenir un token (vous devez créer une app registration avant sur Azure)
 $tenantId = "xxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxxx"
 $clientId = "6485668-4301-5cb9-c40d-xxxxxxxxxxxxx"
 $clientSecret = "--.9G~SimYD7L6NAFE12IuGwioPNEOgP8f5U4b63"
 $companyId = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" 
 
 # Obtenir un token OAuth2
 $tokenUrl = "https://login.microsoftonline.com/$tenantId/oauth2/token"
 $body = @{
     grant_type    = "client_credentials"
     client_id     = $clientId
     client_secret = $clientSecret
     resource      = "https://api.businesscentral.dynamics.com"
 }
 
 $response = Invoke-RestMethod -Method Post -Uri $tokenUrl -ContentType "application/x-www-form-urlencoded" -Body $body
 $accessToken = $response.access_token

     #### PUBLICATION DE L'EXTENSION ##########
     # === ÉTAPE 1 : INSERT EXTENSION UPLOAD ===
     $uploadUrl = "https://api.businesscentral.dynamics.com/v2.0/$tenantId/$environmentName/api/microsoft/automation/v2.0/companies($companyId)/extensionUpload"
     $headers = @{ Authorization = "Bearer $accessToken"; "Content-Type" = "application/json" }
 
     $body = @{ 
         schedule = "Current version"
         schemaSyncMode = "Add" 
     }
     $bodyJson = $body | ConvertTo-Json 
     try {
         $response = Invoke-WebRequest -Method Post -Uri $uploadUrl -Headers $headers -Body $bodyJson
         $response.Content 
     }
     catch {
         Write-Host "Erreur : $($_.Exception.Message)"
 
             # Si c’est une erreur HTTP, on récupère .Response
             if ($_.Exception.Response -and $_.Exception.Response -is [System.Net.HttpWebResponse]) {
                 $httpResponse = $_.Exception.Response
                 Write-Host "Statut HTTP : $($httpResponse.StatusCode)"
                 # Récupérer le contenu brut
                 $stream = $httpResponse.GetResponseStream()
                 if ($stream) {
                     $reader = New-Object System.IO.StreamReader($stream)
                     $body = $reader.ReadToEnd()
                     Write-Host "Contenu de la réponse d'erreur :"
                     Write-Host $body
                 }
             }
     }
 
 
     $json = $response.Content | ConvertFrom-Json
     $extensionUploadId = $json.systemId
 
 
     Write-Host "Extension Upload creee. ID: $extensionUploadId"
 
 
     # === ÉTAPE 2 : UPLOAD EXTENSION FILE ===
     $appFilePath = "C:\TestsBC\NEURONES_MonExtension_3.0.0.21.app"
     $uploadFileUrl = "https://api.businesscentral.dynamics.com/v2.0/$tenantId/$environmentName/api/microsoft/automation/v2.0/companies($companyId)/extensionUpload($extensionUploadId)/extensionContent"
     $headersUpload = @{
         Authorization = "Bearer $accessToken"
         "Content-Type" = "application/octet-stream"
         "If-Match" = "*"
     }
     Invoke-RestMethod -Uri $uploadFileUrl -Method Patch -Headers $headersUpload -InFile $appFilePath -ContentType "application/octet-stream"
 
     Write-Host "Fichier .app televerse avec succes."
 
     # === ÉTAPE 3 : INSTALL EXTENSION ===
 
     $installUrl = "https://api.businesscentral.dynamics.com/v2.0/$tenantId/$environmentName/api/microsoft/automation/v2.0/companies($companyId)/extensionUpload($extensionUploadId)/Microsoft.NAV.upload"
     $headersInstall = @{ Authorization = "Bearer $accessToken" }
     Invoke-RestMethod -Uri $installUrl -Method Post -Headers $headersInstall
 
     Write-Host "Extension en cours d'installation..."
 
     # === ÉTAPE 4 : CHECK EXTENSION STATUS ===
     $statusUrl = "https://api.businesscentral.dynamics.com/v2.0/$tenantId/$environmentName/api/microsoft/automation/v2.0/companies($companyId)/extensionDeploymentStatus"
     $statusResponse = Invoke-RestMethod -Uri $statusUrl -Headers @{ Authorization = "Bearer $accessToken" } -Method Get
 
     $statusResponse.value | Sort-Object startedOn -Descending | Select-Object -First 5 | Format-Table name, status, startedOn
 
     $targetExtensionName = "NEURONES_MonExtension"
 
     $maxAttempts = 80 # (40 x 15s)
     $attempt = 0
 
     do {
         $statusResponse = Invoke-RestMethod -Uri $statusUrl -Headers @{ Authorization = "Bearer $accessToken" } -Method Get
 
         $latestStatus = $statusResponse.value |
             Where-Object { $_.name -eq $targetExtensionName } |
             Sort-Object startedOn -Descending |
             Select-Object -First 1
 
         if ($null -ne $latestStatus) {
             Write-Host "Tentative $attempt - Statut : $($latestStatus.status) (demarre le $($latestStatus.startedOn))"
         } else {
             Write-Host "Tentative $attempt - Extension non encore visible dans le statut."
         }
 
         # Si terminé ou échec, sortir de la boucle
         if ($latestStatus.status -in @("Completed", "Failed")) {
             break
         }
 
         Start-Sleep -Seconds 15
         $attempt++
 
     } while ($attempt -lt $maxAttempts)
 
     Write-Host "Dernier statut connu : $($latestStatus.name) → $($latestStatus.status)"
