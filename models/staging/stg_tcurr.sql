SELECT
    KESSION AS rate_type,
    FCURR AS from_currency,
    TCURR AS to_currency,
    GDESSION_TC AS valid_from_date,
    UKURS AS exchange_rate,
    FFACT AS from_factor,
    TFACT AS to_factor
FROM {{ source('sap', 'TCURR') }}
WHERE MANDT = '100'
