SELECT
    SPRAS AS language_key,
    KTOPL AS chart_of_accounts,
    SAESSION_SK AS gl_account,
    TXT20 AS gl_account_short_text,
    TXT50 AS gl_account_long_text
FROM {{ source('sap', 'SKAT') }}
WHERE MANDT = '100'