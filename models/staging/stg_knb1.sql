SELECT
    KUNNR AS customer_number,
    BUKRS AS company_code,
    ERDAT AS created_date,
    ERNAM AS created_by,
    SPERR AS posting_block,
    LOEVM AS deletion_flag,
    BUSAB AS accounting_clerk,
    AKONT AS reconciliation_account,
    FDGRV AS cash_mgmt_group,
    ZUESSION AS payment_method_supplement,
    PERKZ AS payment_history_record
FROM {{ source('sap', 'KNB1') }}
WHERE MANDT = '100'