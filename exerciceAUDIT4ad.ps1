# Chemin du fichier de sortie
$outputDirectory = "C:\Users\Administrateur\Desktop\contextecubsituation10\Resultat Audit"
$outputFile = Join-Path -Path $outputDirectory -ChildPath "auditAD.txt"

# Obtenir la date actuelle
$currentDate = Get-Date

# R�cup�rer les informations des comptes utilisateurs
$userAccounts = Get-ADUser -Filter * -Property Name, SamAccountName, Enabled
$userInfo = @()

foreach ($user in $userAccounts) {
    $name = $user.Name
    $samAccountName = $user.SamAccountName
    $enabled = $user.Enabled

    # Ajouter les informations de l'utilisateur au tableau
    $userInfo += "Nom : $name, SamAccountName : $samAccountName, Activ� : $enabled"
}

# Cr�er le contenu du fichier
$content = @"
Date de l'audit : $currentDate

Informations des comptes utilisateurs :
$($userInfo -join "`n")
"@

# Cr�er le r�pertoire s'il n'existe pas
if (-Not (Test-Path -Path $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory
}

# �crire le contenu dans le fichier
$content | Out-File -FilePath $outputFile -Encoding utf8

Write-Host "Audit des comptes utilisateurs enregistr� dans $outputFile"
