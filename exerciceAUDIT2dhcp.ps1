# Chemin du fichier de sortie
$outputDirectory = "C:\Users\Administrateur\Desktop\contextecubsituation10\Resultat Audit"
$outputFile = Join-Path -Path $outputDirectory -ChildPath "auditDHCP.txt"

# Obtenir la date actuelle
$currentDate = Get-Date

# V�rifier l'�tat des plages DHCP
$scopes = Get-DhcpServerv4Scope -ErrorAction SilentlyContinue
$scopeStatus = @()

foreach ($scope in $scopes) {
    $scopeName = $scope.Name
    $scopeState = $scope.State

    # Ajouter le statut de la plage au tableau
    $scopeStatus += "$scopeName : $scopeState"

    # Afficher � l'�cran avec mise en forme
    if ($scopeState -eq "Inactive") {
        Write-Host "$scopeName : $scopeState" -ForegroundColor Red
    } else {
        Write-Host "$scopeName : $scopeState"
    }
}

# Cr�er le contenu du fichier
$content = @"
Date de l'audit : $currentDate

�tat des plages DHCP :
$($scopeStatus -join "`n")
"@

# �crire le contenu dans le fichier
$content | Out-File -FilePath $outputFile -Encoding utf8

Write-Host "Audit des plages DHCP enregistr� dans $outputFile"
