SELECT
    ORDER_ID AS sales_document,
    ORDER_ITEM AS item_number,
    CONTRACT_ID AS contract_id,
    POB_ID AS pob_id,
    QUANTITY AS quantity,
    CURRENCY AS currency,
    TRANSACTION_AMOUNT AS transaction_amount,
    MATNR AS material_number,
    KUNNR AS customer_number,
    ERDAT AS created_date
FROM {{ source('sap', 'FARR_D_ORDER_I') }}
WHERE MANDT = '100'