# Conecte-se ao Azure AD (faça login com suas credenciais)
Connect-AzureAD

# Defina o nome do grupo de segurança
$groupName = "Azure-UC-MOBILY-ACCESS"

# Obtenha o objeto do grupo de segurança
$group = "2c057000-d5ec-4738-a800-f7b36010e2be"

# Verifique se o grupo foi encontrado

# Remova os usuários do grupo
$usersToRemove = @("marcos.vigliassi@embraer.com.br","michael.bennett@embraer.com","rwilleford@embraer.com","jason.ferguson@embraer.com","redginton@embraer.com","shuntsman@embraer.com","rosanna.jasso@embraer.com","ricardo.rodriguez@embraer.com","michael.adams@embraer.com","gregory.vici@embraer.com","kyle.bollig@embraer.com","aguinaldo.rodrigues@embraer.com","mpettis@embraer.com","john.simmons@embraer.com","kcleveland@embraer.com","cmills@embraer.com","clyde.markham@embraer.com","joseph.sylvia@embraer.com","john.dubbs@embraer.com","lina.arciniegas@embraer.com","nlewis@embraer.com","teresa.deem@embraer.com","jacob.holanda@embraer.com","derek.lafon@embraer.com","jmccray@embraer.com","bradley.wallace@embraer.com","anika.ahmed@embraer.com","collette.elise@embraer.com","andy.depriest@embraer.com","donna.clement@embraer.com","juliete.capaz@embraer.com.br","yulia.fricker@eveairmobility.com","marcos.stockl@embraer.com","john.ernsberger@embraer.com","jmilinski@embraer.com","brahn@embraer.com","jbiran@embraer.com","carolyn.turner@embraer.com","lucas.porto@embraer.com.br","ryan.gleason@embraer.com","klehman@embraer.com","cgilkes@embraer.com","lesley.bowser@embraer.com","dthompson@embraer.com","adrian.gomez@embraer.com","david.lopez@embraer.com","shealtiel.javier@embraer.com","paul.paonessa@embraer.com","nicolas.grayford@embraer.com","rhess@embraer.com","brett.adams@embraer.com","heloisa.tubouti@embraer.com","jonathan.price@embraer.com","jfannin@embraer.com","CHart@embraer.com","LBarbosa@embraer.com","stacy.andon@embraer.com","JNelson@embraer.com","jklemin@embraer.com","GRHARDISON@embraer.com","rodrigo.flores@eveairmobility.com","mpenney@embraer.com","ricardo.silveira@embraer.com","robby.lewis@embraer.com","william.ache@embraer.com","shjones@embraer.com","julia.anton@embraer.com","emanuela.paiva@embraer.com","cassaundra.ross@embraer.com","maurice.thompson@embraer.com","yasyrie.guzman@embraer.com","jose.sebastiao@embraer.com","sergio.fajerman.bkp@embraer.com.br","pedwong@embraer.com.br","sergio.eraldo.bkp@embraer.com.br","sidney.fukayama@eveairmobility.com","everson.moura@embraer.com.br","marcelo.damasceno@embraer.com.br","iuri@eveairmobility.com","beatriz.botelho@embraer.com.br","alexis@eveairmobility.com","davie.receiving@embraer.com","mbarendregt@nl.embraer.com","fernando.fonseca@embraer.com.br","mtran@embraer.com","danielle.vardaro@embraer.com","boril.yonchev@nl.embraer.com","kai.ehrenreich@nl.embraer.com","mathys.fourie@embraer.com","marcelo.siqueira@embraer.com.br","aaron.benbow@eveairmobility.com","ivan.carmo@embraer.com.br","josemauro.vilela.bkp@embraer.com.br","marion.blakey@eveairmobility.com","julio.tosi@globmail.com.br","sergio.eraldo@embraer.com.br","sergio.fajerman@embraer.com.br","josemauro.vilela@embraer.com.br","kenn.ricci@eveairmobility.com","desuita.campelo@embraer.com.br")  # Substitua pelos UPNs dos usuários a serem removidos
foreach ($user in $usersToRemove) {
    Remove-AzureADGroupMember -ObjectId $group -MemberId (Get-AzureADUser -ObjectId $user).ObjectId
    Write-Host "Usuário $user removido do grupo $groupName."
}

