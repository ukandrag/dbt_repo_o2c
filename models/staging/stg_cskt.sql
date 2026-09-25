SELECT
    SPRAS AS language_key,
    KOKRS AS controlling_area,
    KOSTL AS cost_center,
    DATBI AS valid_to,
    KTEXT AS cost_center_short_text,
    LTEXT AS cost_center_long_text
FROM {{ source('sap', 'CSKT') }}
WHERE MANDT = '100'