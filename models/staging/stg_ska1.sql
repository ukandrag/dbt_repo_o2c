SELECT
    KTOPL AS chart_of_accounts,
    SAESSION AS gl_account,
    ERDAT AS created_date,
    KTOKS AS gl_account_group,
    XBILK AS balance_sheet_flag,
    FUNC_AREA AS functional_area,
    BILKT AS alternative_account
FROM {{ source('sap', 'SKA1') }}
WHERE MANDT = '100'