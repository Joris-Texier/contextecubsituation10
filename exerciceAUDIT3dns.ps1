# Chemin du fichier de sortie
$outputDirectory = "C:\Users\Administrateur\Desktop\contextecubsituation10\Resultat Audit"
$outputFile = Join-Path -Path $outputDirectory -ChildPath "auditDNS.txt"

# Obtenir la date actuelle
$currentDate = Get-Date

# R�cup�rer les enregistrements DNS de type A
$dnsRecords = Get-DnsServerResourceRecord -ZoneName "local.anvers.cub.sioplc.fr" -RRType A -ErrorAction SilentlyContinue
$dnsEntries = @()

foreach ($record in $dnsRecords) {
    $name = $record.HostName
    $ipAddress = $record.RecordData.IPv4Address

    # Ajouter l'enregistrement DNS au tableau
    $dnsEntries += "$name : $ipAddress"
}

# Cr�er le contenu du fichier
$content = @"
Date de l'audit : $currentDate

Enregistrements DNS de type A :
$($dnsEntries -join "`n")
"@

# Cr�er le r�pertoire s'il n'existe pas
if (-Not (Test-Path -Path $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory
}

# �crire le contenu dans le fichier
$content | Out-File -FilePath $outputFile -Encoding utf8

Write-Host "Audit des enregistrements DNS enregistr� dans $outputFile"

