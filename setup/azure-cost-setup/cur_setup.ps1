  # PowerShell Script

# Resource Group parameters
$resourceGroupName = "po-external-rg"
# Location
$location = "East US"
# Storage Account 
$storageAccountName = "poexternaldailycur"
# Storage Container parameters
$containerName = "curexport"
# ActualCost Report name
$actualCostReportName = "actualdailycur"
# AmortizedCost Report name
$amortizedCostReportName = "amortizeddailycur"
#

# Install Azure PowerShell cmdlets
Install-Module -Name Az -AllowClobber -Scope CurrentUser
Install-Module -Name Az.CostManagement -Scope CurrentUser
# PowerShell Script using Azure PowerShell cmdlets

# Login to Azure and get subscriptions
Connect-AzAccount -WarningAction SilentlyContinue
$subscriptions = Get-AzSubscription -WarningAction SilentlyContinue
if (-not $subscriptions) {
    Write-Output ("Failed to query subscriptions: " + $Error[0])
    exit
}

if ($subscriptions.Count -eq 0) {
     Write-Output "No subscriptions present"
     exit
}
    
$subscriptionIds = $subscriptions | Select-Object -ExpandProperty Id

# Iterate through each subscription ID
foreach ($subscriptionId in $subscriptionIds) {
    Write-Output $subscriptionId

    # Set the current subscription
    Set-AzContext -SubscriptionId $subscriptionId -WarningAction SilentlyContinue

    # Check if the resource group exists
    $rg_group = Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
    if (-not $rg_group) {
        # Create a resource group
        $rg_group = New-AzResourceGroup -Name $resourceGroupName -Location $location  -ErrorAction SilentlyContinue
    }
    
    if (-not $rg_group) {
        Write-Error ("Unable to create resource group : " + $Error[0])
        exit
    }

    # Check if the storage account exists
    $storageAccountExists = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -ErrorAction SilentlyContinue
    if (-not $storageAccountExists) {
        # Create a storage account
        $storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroupName -AccountName $storageAccountName -Location $location -SkuName "Standard_LRS"  -ErrorAction SilentlyContinue
    } else {
        $storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName  -ErrorAction SilentlyContinue
    } 

    if (-not $storageAccount) {
        Write-Error ("Unable to query storageAccount: " + $Error[0])
        exit
    }

    # Check if the storage container exists
    $storcontainer = Get-AzStorageContainer -Context $storageAccount.Context -Name $containerName -ErrorAction SilentlyContinue  -WarningAction SilentlyContinue
    if (-not $storcontainer) {
        # Create a storage container
        $storcontainer = New-AzStorageContainer -Name $containerName -Context $storageAccount.Context  -WarningAction SilentlyContinue
    }
    
    if (-not $storcontainer) {
        Write-Error ("Unable to query storage container: " + $Error[0])
        exit
    }

    $resource = Get-AzResource -ResourceGroupName $resourceGroupName -Name $storageAccountName
    $subscope = "/subscriptions/" + $subscriptionId
    $recur_from_time = (Get-Date).ToUniversalTime().AddHours(1).ToString("yyyy-MM-ddTHH:mm:ssZ")
    $recur_to_time = (Get-Date).ToUniversalTime().AddHours(1).AddYears(3).ToString("yyyy-MM-ddTHH:mm:ssZ")

    # Create ActualCost export
    New-AzCostManagementExport -Scope $subscope -Name $actualCostReportName -ScheduleStatus "Active" -ScheduleRecurrence "Daily" -RecurrencePeriodFrom $recur_from_time -RecurrencePeriodTo $recur_to_time -Format "Csv"  -DestinationResourceId $resource.ResourceId -DestinationContainer $containerName -DestinationRootFolderPath $actualCostReportName -DefinitionType "ActualCost" -DefinitionTimeframe "BillingMonthToDate" -DatasetGranularity "Daily"

    # Create AmortizedCost export
    New-AzCostManagementExport -Scope $subscope -Name $amortizedCostReportName -ScheduleStatus "Active" -ScheduleRecurrence "Daily" -RecurrencePeriodFrom $recur_from_time -RecurrencePeriodTo $recur_to_time -Format "Csv"  -DestinationResourceId $resource.ResourceId -DestinationContainer $containerName -DestinationRootFolderPath $amortizedCostReportName -DefinitionType "AmortizedCost" -DefinitionTimeframe "BillingMonthToDate" -DatasetGranularity "Daily"

}

#Get the reports
$current_list_of_reports = Get-AzCostManagementExport -Scope $subscope
Write-Output ($current_list_of_reports  + ',' +  $subscriptionId + ',' + $storageAccountName  + ',' +  $containerName)

Write-Output "Script execution completed."
