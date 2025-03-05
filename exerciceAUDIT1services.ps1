# Chemin du fichier de sortie
$outputDirectory = "C:\Users\Administrateur\Desktop\contextecubsituation10\Resultat Audit"
$outputFile = Join-Path -Path $outputDirectory -ChildPath "auditService.txt"

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
Date de l'audit : $currentDate

�tat des services :
$($serviceStatus -join "`n")
"@

# Cr�er le r�pertoire s'il n'existe pas
if (-Not (Test-Path -Path $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory
}

# �crire le contenu dans le fichier
$content | Out-File -FilePath $outputFile -Encoding utf8

Write-Host "Audit des services enregistr� dans $outputFile"
