param webAppName string = 'cicdexpressapp' // Generate unique String for web app name
param sku string = 'F1' // The SKU of App Service Plan
param linuxFxVersion string = 'node|18-lts' // The runtime stack of web app
param location string = resourceGroup().location // Location for all resources
param repositoryUrl string = 'https://github.com/ckng0221/js-e2e-express-server'
param branch string = 'main'
var appServicePlanName = toLower('AppServicePlan-${webAppName}')
// var webSiteName = toLower('wapp-${webAppName}')
var webSiteName = webAppName

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  properties: {
    reserved: true
  }
  sku: {
    name: sku
  }
  kind: 'linux'
}

resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: webSiteName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
    }
  }
}

// To connect with your repo. (Optional)
resource srcControls 'Microsoft.Web/sites/sourcecontrols@2021-01-01' = {
  parent: appService
  name: 'web'
  properties: {
    repoUrl: repositoryUrl
    branch: branch
    isManualIntegration: true
  }
}
