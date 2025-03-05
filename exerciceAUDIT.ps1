# Charger l'assembly Windows Forms
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

# Créer la fenêtre principale
$Form = New-Object System.Windows.Forms.Form
$Form.ClientSize = '400,300'
$Form.Text = "Mon UI en PS"
$Form.FormBorderStyle = 'Fixed3D'
$Form.MaximizeBox = $false

# Créer les boutons pour chaque audit
$ButtonAuditServices = New-Object System.Windows.Forms.Button
$ButtonAuditServices.Location = New-Object System.Drawing.Point(30, 30)
$ButtonAuditServices.Width = 150
$ButtonAuditServices.Height = 50
$ButtonAuditServices.Text = "Audit Services"

$ButtonAuditDHCP = New-Object System.Windows.Forms.Button
$ButtonAuditDHCP.Location = New-Object System.Drawing.Point(30, 100)
$ButtonAuditDHCP.Width = 150
$ButtonAuditDHCP.Height = 50
$ButtonAuditDHCP.Text = "Audit DHCP"

$ButtonAuditDNS = New-Object System.Windows.Forms.Button
$ButtonAuditDNS.Location = New-Object System.Drawing.Point(200, 30)
$ButtonAuditDNS.Width = 150
$ButtonAuditDNS.Height = 50
$ButtonAuditDNS.Text = "Audit DNS"

$ButtonAuditAD = New-Object System.Windows.Forms.Button
$ButtonAuditAD.Location = New-Object System.Drawing.Point(200, 100)
$ButtonAuditAD.Width = 150
$ButtonAuditAD.Height = 50
$ButtonAuditAD.Text = "Audit AD"

# Ajouter les boutons à la fenêtre
$Form.Controls.AddRange(@($ButtonAuditServices, $ButtonAuditDHCP, $ButtonAuditDNS, $ButtonAuditAD))

# Ajouter les EventHandlers pour lancer les scripts
$ButtonAuditServices.Add_Click({
    Start-Process powershell.exe -ArgumentList "-File", "C:\Users\Administrateur\Desktop\contextecubsituation10\exerciceAUDIT1services.ps1"
})

$ButtonAuditDHCP.Add_Click({
    Start-Process powershell.exe -ArgumentList "-File", "C:\Users\Administrateur\Desktop\contextecubsituation10\exerciceAUDIT2dhcp.ps1"
})

$ButtonAuditDNS.Add_Click({
    Start-Process powershell.exe -ArgumentList "-File", "C:\Users\Administrateur\Desktop\contextecubsituation10\exerciceAUDIT3dns.ps1"
})

$ButtonAuditAD.Add_Click({
    Start-Process powershell.exe -ArgumentList "-File", "C:\Users\Administrateur\Desktop\contextecubsituation10\exerciceAUDIT4ad.ps1"
})

# Afficher la fenêtre
$Form.ShowDialog()
