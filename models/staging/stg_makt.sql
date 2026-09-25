SELECT
    MATNR AS material_number,
    SPRAS AS language_key,
    MAKTX AS material_description,
    MAKTG AS material_description_upper
FROM {{ source('sap', 'MAKT') }}
WHERE MANDT = '100'
