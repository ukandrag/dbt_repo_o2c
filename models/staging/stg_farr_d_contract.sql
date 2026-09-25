SELECT
    CONTRACT_ID AS contract_id,
    CONTRACT_TYPE AS contract_type,
    CUSTOMER_ID AS customer_number,
    START_DATE AS contract_start_date,
    END_DATE AS contract_end_date,
    CURRENCY AS currency,
    BUKRS AS company_code,
    VKORG AS sales_organization,
    VTWEG AS distribution_channel,
    SPART AS division,
    CONTRACT_STATUS AS contract_status,
    ERDAT AS created_date,
    ERNAM AS created_by
FROM {{ source('sap', 'FARR_D_CONTRACT') }}
WHERE MANDT = '100'