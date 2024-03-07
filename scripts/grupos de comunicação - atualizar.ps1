#Parte para abrir a janela de dialogo para escolher o arquivo
[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
$OpenFIleDialog = New-Object System.Windows.Forms.OpenFileDialog
$OpenFileDialog.InitialDirectory = $InitialDirectory
$OpenFileDialog.Filter = "CSV (*.csv) | *.csv"
$OpenFileDialog.ShowDialog() | Out-Null

#Separação das variaveis para trabalhar nelas posteriormente
$Path = $OpenFileDialog.Filename
$NomeDoArquivo = [System.IO.Path]::GetFileNameWithoutExtension($Path)
$Users = (Import-Csv -Path $Path)."Email"
$UserParaZerarGrupo = "maycon.rocha365@globmail.com.br"

#Amostragem de usuarios e grupo escolhi
$Users
$NomeDoArquivo

#Sessão para confirmar o grupo e utilizar o objeto dele, invés do nome que pode causar erro se houver duplicidade.
#$Idgrupo=get-distributiongroup -ResultSize unlimited | where {$_.displayname -eq "$nomedoarquivo”} | select DisplayName, primarysmtpaddress
#$nomedoarquivo=$Idgrupo.PrimarySmtpAddress

#Parte para atualizar o grupo com somente 1 membro e depois removendo o membro usado para zerar o grupo.
Update-distributionGroupMember -identity $NomeDoArquivo -Member $UserParaZerarGrupo -Confirm:$false
Remove-distributionGroupMember -identity $NomeDoArquivo -Member $UserParaZerarGrupo -Confirm:$false

#Bloco de adição de usuarios 1 a 1 e captura dos erros e respectivos emails.
Try {
$Users | foreach{Add-DistributionGroupMember -Identity $NomeDoArquivo -Member $_
write-host -f Blue "Adicionando:" $_}
}
Catch {
write-host -f Red "Error:" $Users
}

write-host -f Green "COMPLETOU O GRUPO " $NomeDoArquivo