$CAMINHODOCSV = "c:\Users\Maycon\Documents\Notepads\Grupos secretarias.csv"

$teste = import-csv -path $CAMINHODOCSV
$secretarias = (get-content -path $CAMINHODOCSV -TotalCount 1) -split ","

$i = 0
foreach ($Grupo in $Secretarias) {

#BLOCO PARA PEGAR O NOME DO GRUPO BASEADO NO ARRAY CRIADO
$nomegrupocoluna = $secretarias[$i]
Write-Host ("=" * 40) -ForegroundColor red
Write-host "Grupo a ser mexido: $NomeGrupoColuna"
Write-Host ("=" * 40) -ForegroundColor red


#BLOCO PARA PEGAR OS MEMBROS DO GRUPO
$membroscoluna = $teste.($secretarias[$i]) | Where-Object {$_ -ne ""}

write-host 'REPRESENTAÇÃO DOS MEMBROS SEM OS ESPAÇOS EM BRANCO'
Write-Host ("=" * 40) -ForegroundColor Blue
$membroscoluna 
Write-Host ("=" * 40) -ForegroundColor Blue


#ZERAR OS GRUPOS PARA ADICIONAR OS USUARIOS CORRETOS

Update-DistributionGroupMember -identity $nomegrupocoluna -Members TesteOOO@embraer.com.br -confirm:$false
Remove-DistributionGroupMember -Identity $nomegrupocoluna -Member TesteOOO@embraer.com.br -confirm:$false

#ADICIONAR OS USUARIOS CORRETOS

foreach ($membro in $membroscoluna){
	Add-DistributionGroupMember -identity $nomegrupocoluna -Member $membro
	write-Host "MEMBRO ADICIONADO: $membro" -ForegroundColor Green
}

#ADIÇÃO DO CONTADOR PARA SEREM USADOS PRA ACESSAR OS DIFERENTES VALORES DENTRO DO CSV E DO ARRAY DE SECRETARIAS
$i++
}