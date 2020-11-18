# Microsoft 365 Data Protection - Azure Cleanup

Rubrik Polaris automatically creates a new Azure Resource Group that logically contains several components required for Microsoft 365 Data Protection. However, Polaris does not have the ability to remove the Resource Group. This PowerShell script automates that cleanup process and ensures all of the create components are removed.

# :blue_book: Documentation

1. Download the `365-Azure-Environment-Cleanup.ps1` PowerShell script

2. Execute the PowerShell Script

    `./365-Azure-Environment-Cleanup.ps1`

3. Through the web browser, provide your Azure login credentials.

4. Select the Azure Subscription where the Resource Group that needs to be deleted lives.

5. Select the Resource Group that needs to be deleted.

6. Confirm you wish for the deletion to proceed.


```
PS /Users/drewrussell/Development/microsoft-365-cleanup> ./365-Azure-Environment-Cleanup.ps1

Removing the Rubrik Enterprise App

Microsoft Azure Subscriptions:
 0: RubrikSub1
 1: RubrikSub2

Which Subscription contains the Azure Resource Group to delete? [0-1]: 0

Subscription Resource Groups:
 0: cloud-shell-storage-westeurope
 1: cloud-shell-storage-southcentralus
 2: svc-rubrik-cloudout
 3: polaris-0365-protection

Which Resource Group would you like to delete?? [0-3]: 3

Confirm
Are you sure you want to remove resource group 'polaris-0365-protection'
[Y] Yes [N] No [S] Suspend [?] Help (default is "Yes"): Y
```

# :white_check_mark: Prerequisites

There are a few services you'll need in order to run the cleanup script:

* PowerShell 5.1 on Windows, and PowerShell 7.x and higher on all platforms.
* [Azure PowerShell](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-5.1.0)

# :pushpin: License

* [MIT License](LICENSE)

