#### TABLE NAME : aws_cur_report
* The table name `aws_cur_report` is the default table name. You can change the table name as per your requirement. AWS cost and usage reports are stored in this table and the same table/data contains both unblended and amortized costs.

### Query: cost_insights by Account Unblended Cost

```sql
            SELECT
                toYYYYMM(`lineItem/UsageStartDate`) AS year_month,
                `lineItem/UsageAccountId` AS account_id,
                ROUND(SUM(toFloat32OrNull(`lineItem/UnblendedCost`)),2) AS usage_cost

            FROM aws_cur_report
            WHERE
            `lineItem/UsageStartDate` <='2024-01-07 23:59:00'
            AND `lineItem/UsageStartDate` >='2023-02-01 00:00:00'

            GROUP BY
                year_month,
                account_id

            ORDER BY
                year_month DESC
```


### Query: cost_insights by Amortized Cost

```sql
            SELECT 
                toYYYYMM(`lineItem/UsageStartDate`) AS year_month,
                `lineItem/UsageAccountId` AS account_id,
                
                ROUND(
                        SUM(
                            multiIf(
                                `lineItem/LineItemType` = 'SavingsPlanCoveredUsage',
                                toFloat32OrNull(`savingsPlan/SavingsPlanEffectiveCost`),
                                `lineItem/LineItemType` = 'SavingsPlanRecurringFee',
                                round(
                                    toFloat32OrNull(`savingsPlan/TotalCommitmentToDate`) - toFloat32OrNull(`savingsPlan/UsedCommitment`),
                                    8
                                ),
                                `lineItem/LineItemType` = 'SavingsPlanNegation',
                                0,
                                `lineItem/LineItemType` = 'SavingsPlanUpfrontFee',
                                0,
                                `lineItem/LineItemType` = 'DiscountedUsage',
                                toFloat32OrNull(`reservation/EffectiveCost`),
                                `lineItem/LineItemType` = 'RIFee',
                                toFloat32OrNull(
                                    `reservation/UnusedAmortizedUpfrontFeeForBillingPeriod`
                                ) + toFloat32OrNull(`reservation/UnusedRecurringFee`),
                                (`lineItem/LineItemType` = 'Fee')
                                AND (`reservation/ReservationARN` != ''),
                                0,
                                toFloat32OrNull(`lineItem/UnblendedCost`)
                            )
                        ),
                        2
                    ) AS amortized_cost
            
            
            FROM aws_cur_report
            WHERE 
            `lineItem/UsageStartDate` <='2024-01-07 23:59:00' 
            AND `lineItem/UsageStartDate` >='2023-02-01 00:00:00'
            
            GROUP BY 
                year_month, 
                account_id
            
            ORDER BY 
                year_month DESC 
```
