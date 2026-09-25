SELECT
    POB_ID AS pob_id,
    VBTYP AS document_category,
    VBELN AS document_number,
    POSNR AS item_number,
    ASSIGNMENT_PERCENT AS assignment_percent,
    ASSIGNMENT_AMOUNT AS assignment_amount,
    CURRENCY AS currency,
    ERDAT AS created_date
FROM {{ source('sap', 'FARR_D_POB_ASS') }}
WHERE MANDT = '100'
