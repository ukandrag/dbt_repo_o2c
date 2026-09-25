SELECT
    POB_ID AS pob_id,
    CONTRACT_ID AS contract_id,
    POB_STATUS AS pob_status,
    POB_TYPE AS pob_type,
    OPERATIONAL_SOURCE_TYPE AS source_type,
    OPERATIONAL_SOURCE_ID AS source_document,
    TS_AMOUNT AS transaction_price,
    AL_AMOUNT AS allocated_amount,
    CURRENCY AS currency,
    MATNR AS material_number,
    WERKS AS plant,
    ERDAT AS created_date,
    ERNAM AS created_by
FROM {{ source('sap', 'FARR_D_POB') }}
WHERE MANDT = '100'