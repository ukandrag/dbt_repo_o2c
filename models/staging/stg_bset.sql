SELECT
    BUKRS AS company_code,
    BELNR AS accounting_document,
    GJAHR AS fiscal_year,
    BUZEI AS line_item,
    MWSKZ AS tax_code,
    SHKZG AS debit_credit_indicator,
    HWBAS AS tax_base_local_currency,
    FWBAS AS tax_base_document_currency,
    HWSTE AS tax_amount_local_currency,
    FWSTE AS tax_amount_document_currency,
    KTOSL AS transaction_key,
    KSCHL AS condition_type
FROM {{ source('sap', 'BSET') }}
WHERE MANDT = '100'