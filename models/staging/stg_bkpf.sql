SELECT
    BUKRS AS company_code,
    BELNR AS accounting_document,
    GJAHR AS fiscal_year,
    BLART AS document_type,
    BLDAT AS document_date,
    BUDAT AS posting_date,
    MONAT AS fiscal_period,
    CPUDT AS entry_date,
    USNAM AS entered_by,
    TCODE AS transaction_code,
    BKTXT AS header_text,
    XBLNR AS reference_document,
    WAERS AS document_currency,
    KURSF AS exchange_rate,
    BSTAT AS document_status,
    STBLG AS reversal_document,
    STJAH AS reversal_fiscal_year,
    AEDAT AS last_changed_date
FROM {{ source('sap', 'BKPF') }}
WHERE MANDT = '100'