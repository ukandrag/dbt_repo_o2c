SELECT
    BILLING_ID AS billing_document,
    BILLING_ITEM AS billing_item,
    POB_ID AS pob_id,
    ORDER_ID AS sales_document,
    ORDER_ITEM AS sales_item,
    INVOICE_AMOUNT AS invoice_amount,
    CURRENCY AS currency,
    MATNR AS material_number,
    KUNNR AS customer_number,
    BUKRS AS company_code,
    ERDAT AS created_date
FROM {{ source('sap', 'FARR_D_INVOIC_I') }}
WHERE MANDT = '100'