# Connect-AzAccount

Set-AzContext "Azure subscription 1"

$resoureGroupName = "cicdResourceGroup"
New-AzResourceGroup $resoureGroupName -Location 'Southeast Asia'

New-AzResourceGroupDeployment `
    -Name useparameterfile `
    -TemplateFile ./Iac/main.bicep `
    -ResourceGroupName $resoureGroupName `
    -TemplateParameterFile ./Iac/main.parameters.json