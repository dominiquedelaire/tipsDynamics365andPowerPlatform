import requests
import json
import time

# Paramètres à définir
tenant_id = "xxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxxx"
client_id = "6485668-4301-5cb9-c40d-xxxxxxxxxxxxx"
client_secret = "--.9G~SimYD7L6NAFE12IuGwioPNEOgP8f5U4b63"
company_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
environment_name = "Production"  # remplacer par le nom réel de l'environnement

# Obtenir un token OAuth2
token_url = f"https://login.microsoftonline.com/{tenant_id}/oauth2/token"
token_data = {
    "grant_type": "client_credentials",
    "client_id": client_id,
    "client_secret": client_secret,
    "resource": "https://api.businesscentral.dynamics.com"
}

token_response = requests.post(token_url, data=token_data)
token_response.raise_for_status()
access_token = token_response.json()["access_token"]

headers = {"Authorization": f"Bearer {access_token}", "Content-Type": "application/json"}

# Étape 1 : Création de l'extension upload
upload_url = f"https://api.businesscentral.dynamics.com/v2.0/{tenant_id}/{environment_name}/api/microsoft/automation/v2.0/companies({company_id})/extensionUpload"
body = {
    "schedule": "Current version",
    "schemaSyncMode": "Add"
}
response = requests.post(upload_url, headers=headers, json=body)
response.raise_for_status()
extension_upload_id = response.json()["systemId"]

print(f"Extension Upload créée. ID: {extension_upload_id}")

# Étape 2 : Upload du fichier d'extension
app_file_path = r"C:\TestsBC\NEURONES_MonExtension_3.0.0.21.app"
upload_file_url = f"https://api.businesscentral.dynamics.com/v2.0/{tenant_id}/{environment_name}/api/microsoft/automation/v2.0/companies({company_id})/extensionUpload({extension_upload_id})/extensionContent"
headers_upload = {
    "Authorization": f"Bearer {access_token}",
    "Content-Type": "application/octet-stream",
    "If-Match": "*"
}
with open(app_file_path, "rb") as file:
    upload_response = requests.patch(upload_file_url, headers=headers_upload, data=file)
    upload_response.raise_for_status()

print("Fichier .app téléversé avec succès.")

# Étape 3 : Installation de l'extension
install_url = f"https://api.businesscentral.dynamics.com/v2.0/{tenant_id}/{environment_name}/api/microsoft/automation/v2.0/companies({company_id})/extensionUpload({extension_upload_id})/Microsoft.NAV.upload"
install_response = requests.post(install_url, headers={"Authorization": f"Bearer {access_token}"})
install_response.raise_for_status()

print("Extension en cours d'installation...")

# Étape 4 : Vérification du statut d'installation
status_url = f"https://api.businesscentral.dynamics.com/v2.0/{tenant_id}/{environment_name}/api/microsoft/automation/v2.0/companies({company_id})/extensionDeploymentStatus"
target_extension_name = "NEURONES_MonExtension"

max_attempts = 80
attempt = 0

while attempt < max_attempts:
    status_response = requests.get(status_url, headers={"Authorization": f"Bearer {access_token}"})
    status_response.raise_for_status()

    status_entries = status_response.json().get('value', [])
    latest_status = next((entry for entry in sorted(status_entries, key=lambda x: x['startedOn'], reverse=True)
                          if entry['name'] == target_extension_name), None)

    if latest_status:
        print(f"Tentative {attempt} - Statut : {latest_status['status']} (démarré le {latest_status['startedOn']})")

        if latest_status['status'] in ["Completed", "Failed"]:
            break
    else:
        print(f"Tentative {attempt} - Extension non encore visible dans le statut.")

    time.sleep(15)
    attempt += 1

if latest_status:
    print(f"Dernier statut connu : {latest_status['name']} → {latest_status['status']}")
else:
    print("Aucun statut trouvé pour l'extension après le temps écoulé.")
