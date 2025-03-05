# Chemin du fichier de sortie
$outputDirectory = "C:\Users\Administrateur\Desktop\contextecubsituation10\Resultat Audit"
$outputFile = Join-Path -Path $outputDirectory -ChildPath "auditService.txt"

# Obtenir la date actuelle
$currentDate = Get-Date

# Vérifier l'état des services
$services = @("DHCP", "DNS", "ADWS")
$serviceStatus = @()

foreach ($service in $services) {
    $status = Get-Service -Name $service -ErrorAction SilentlyContinue
    if ($status) {
        $serviceStatus += "$service : $($status.Status)"
    } else {
        $serviceStatus += "$service : Non trouvé ou non installé"
    }
}

# Créer le contenu du fichier
$content = @"
Date de l'audit : $currentDate

État des services :
$($serviceStatus -join "`n")
"@

# Créer le répertoire s'il n'existe pas
if (-Not (Test-Path -Path $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory
}

# Écrire le contenu dans le fichier
$content | Out-File -FilePath $outputFile -Encoding utf8

Write-Host "Audit des services enregistré dans $outputFile"
