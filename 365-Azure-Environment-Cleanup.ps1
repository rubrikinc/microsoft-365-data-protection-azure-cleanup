# Supress Warning about more than one active subscription during the initial Connect-AzAccount
$WarningPreference = "SilentlyContinue"

# Open webpage to authenticate to Azure
Connect-AzAccount | Out-Null
$Subscriptions = Get-AzSubscription

Write-Output "Microsoft Azure Subscriptions:"
# Loop through all Subscriptions and write to screen
for ($counter = 0; $counter -lt $subscriptions.Count; $counter++) {
    $subscriptionName = $Subscriptions[$counter].Name
    Write-Output -InputObject " ${counter}: ${subscriptionName}" 
}

# Create user prompt for selecting the correct Subscription
$SubscriptionPrompt = "`nWhich Subscription contains the Azure Resource Group to delete? [0-" + ($Subscriptions.Count - 1) + "]"
$CustomerSelectedSubscription = Read-Host -Prompt $SubscriptionPrompt
# Validate the provided Subscription Number is valid
While (!($CustomerSelectedSubscription -In 0 .. ($Subscriptions.Count - 1))) {

    Write-Host "`nEnter a valid Subscription number." -ForegroundColor Red
    $CustomerSelectedSubscription = Read-Host -Prompt $SubscriptionPrompt

    IF (!($CustomerSelectedSubscription -In 0 .. ($Subscriptions.Count - 1))) {
        continue
    }
    Else {
        break
    }
}


# Set the script execution context to the provided Subscription
Set-AzContext -Subscription $Subscriptions[$CustomerSelectedSubscription].Name | Out-Null

$ResourceGroups = Get-AzResourceGroup
Write-Output "`nSubscription Resource Groups:"
# Loop through all Resource Groups and write to screen
for ($counter = 0; $counter -lt $ResourceGroups.Count; $counter++) {
    $resourceGroupName = $ResourceGroups[$counter].ResourceGroupName
    Write-Output -InputObject " ${counter}: ${resourceGroupName}" 
}

# Create user prompt for selecting the Resource Group to delete
$ResourceGroupPrompt = "`nWhich Resource Group would you like to delete?? [0-" + ($ResourceGroups.Count - 1) + "]"
$CustomerSelectedResourceGroup = Read-Host -Prompt $ResourceGroupPrompt
# Validate the provided Resource Group Number is valid
While (!($CustomerSelectedResourceGroup -In 0 .. ($ResourceGroups.Count - 1))) {

    Write-Host "`nEnter a valid Resource Group number." -ForegroundColor Red
    $CustomerSelectedResourceGroup = Read-Host -Prompt $ResourceGroupPrompt

    IF (!($CustomerSelectedResourceGroup -In 0 .. ($ResourceGroups.Count - 1))) {
        continue
    }
    Else {
        break
    }
}

Write-Output ""
# Remove the Resource Group -- this automatically includes a confirmation prompt
Remove-AzResourceGroup -Name $ResourceGroups[$CustomerSelectedResourceGroup].ResourceGroupName


# -AsJob makes this async which is useful if we want to move onto the delete ServicePrincipal step
# Can always just do that first too.
# $DeleteResourceGroup = Remove-AzResourceGroup -Name $ResourceGroups[$CustomerSelectedResourceGroup].ResourceGroupName -AsJob

# Find and Delete the Rubrik Service Principal
# Write-Output "Removing the Rubrik Enterprise App"
# $AllEnterpriseApp = Get-AzADServicePrincipal 
# Remove-AzADServicePrincipal -ServicePrincipalName ($AllEnterpriseApp.DisplayName -match "Rubrik Azure Integration")

