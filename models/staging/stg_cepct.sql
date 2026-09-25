SELECT
    SPRAS AS language_key,
    PRCTR AS profit_center,
    DATBI AS valid_to,
    KOKRS AS controlling_area,
    KTEXT AS profit_center_short_text,
    LTEXT AS profit_center_long_text
FROM {{ source('sap', 'CEPCT') }}
WHERE MANDT = '100'
