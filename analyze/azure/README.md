#### TABLE NAME : azure_cur_report and azure_cur_report_amortized
* The table name `azure_cur_report` is the default table name. You can change the table name as per your requirement. Azure cost and usage reports are stored in this table and the same table/data contains both unblended or ondemand costs. For amortized costs, the table name is `azure_cur_report_amortized`.

### Query: cost_insights by Account Unblended Cost

```sql
            SELECT 
                toYear(`date`) AS year,
                toMonth(`date`) AS month,
                `subscriptionName` AS usage_account_name,
                `SubscriptionId` AS account_id,
                ROUND(SUM(toFloat32OrNull(`costInBillingCurrency`)),2) AS usage_cost
            
            FROM azure_cur_report
            WHERE 
            `date` <='2024-01-07 23:59:00' 
            AND `date` >='2023-02-01 00:00:00'
            
            GROUP BY 
                year,
                month, 
                usage_account_name,
                account_id
            
            ORDER BY 
                year,
                month DESC 
```


### Query: cost_insights by Amortized Cost

```sql
            SELECT 
                toYear(`date`) AS year,
                toMonth(`date`) AS month,
                `subscriptionName` AS usage_account_name,
                `SubscriptionId` AS account_id,                
                ROUND(SUM(toFloat32OrNull(`costInBillingCurrency`)),2) AS amortized_cost                    
            FROM azure_cur_report_amortized
            WHERE 
            `date` <='2024-01-07 23:59:00' 
            AND `date` >='2023-02-01 00:00:00'
            
            GROUP BY 
                year,
                month,
                usage_account_name, 
                account_id
            
            ORDER BY 
                year,
                month DESC 
```


We would love to add queries form our library if we see more interest in this project. Please reach out to us at primeorbitoss@primeorbit.com or visit our website at [primeorbit.com](https://primeorbit.com). We'd be happy to help you with the setup and answer any questions you may have.