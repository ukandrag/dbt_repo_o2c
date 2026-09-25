SELECT
    VBELV AS preceding_document,
    POSNV AS preceding_item,
    VBELN AS subsequent_document,
    POSNN AS subsequent_item,
    VBTYP_V AS preceding_doc_category,
    VBTYP_N AS subsequent_doc_category,
    RFMNG AS transferred_quantity,
    RFWRT AS transferred_value,
    ERDAT AS created_date,
    STUFE AS level,
    BWART AS movement_type,
    FKTYP AS billing_type
FROM {{ source('sap', 'VBFA') }}
WHERE MANDT = '100'