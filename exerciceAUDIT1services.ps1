# Chemin du fichier de sortie
$outputFile = "auditService.txt"

# Obtenir la date actuelle
$currentDate = Get-Date

# V�rifier l'�tat des services
$services = @("DHCP", "DNS", "ADWS")
$serviceStatus = @()

foreach ($service in $services) {
    $status = Get-Service -Name $service -ErrorAction SilentlyContinue
    if ($status) {
        $serviceStatus += "$service : $($status.Status)"
    } else {
        $serviceStatus += "$service : Non trouv� ou non install�"
    }
}

# Cr�er le contenu du fichier
$content = @"
Date de lancement du script : $currentDate

�tat des services :
$($serviceStatus -join "`n")
"@

# �crire le contenu dans le fichier
$content | Out-File -FilePath $outputFile -Encoding utf8

Write-Host "Audit des services enregistr� dans $outputFile"
