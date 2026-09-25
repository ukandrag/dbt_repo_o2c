SELECT
    POB_ID AS pob_id,
    CONTRACT_ID AS contract_id,
    POSTING_PERIOD AS posting_period,
    POST_YEAR AS posting_year,
    LINE_NO AS line_number,
    POSTING_DATE AS posting_date,
    BETRG AS posting_amount,
    CRNCY AS currency,
    CATEGORY AS posting_category,
    BUKRS AS company_code,
    HKONT AS gl_account,
    KOSTL AS cost_center,
    PRCTR AS profit_center,
    ERDAT AS created_date
FROM {{ source('sap', 'FARR_D_POSTING') }}
WHERE MANDT = '100'