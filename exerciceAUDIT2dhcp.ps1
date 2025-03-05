# Chemin du fichier de sortie
$outputDirectory = "C:\Users\Administrateur\Desktop\contextecubsituation10\Resultat Audit"
$outputFile = Join-Path -Path $outputDirectory -ChildPath "auditDHCP.txt"

# Obtenir la date actuelle
$currentDate = Get-Date

# Vérifier l'état des plages DHCP
$scopes = Get-DhcpServerv4Scope -ErrorAction SilentlyContinue
$scopeStatus = @()

foreach ($scope in $scopes) {
    $scopeName = $scope.Name
    $scopeState = $scope.State

    # Ajouter le statut de la plage au tableau
    $scopeStatus += "$scopeName : $scopeState"

    # Afficher à l'écran avec mise en forme
    if ($scopeState -eq "Inactive") {
        Write-Host "$scopeName : $scopeState" -ForegroundColor Red
    } else {
        Write-Host "$scopeName : $scopeState"
    }
}

# Créer le contenu du fichier
$content = @"
Date de l'audit : $currentDate

État des plages DHCP :
$($scopeStatus -join "`n")
"@

# Écrire le contenu dans le fichier
$content | Out-File -FilePath $outputFile -Encoding utf8

Write-Host "Audit des plages DHCP enregistré dans $outputFile"
