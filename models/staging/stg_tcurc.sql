SELECT
    WAERS AS currency_code,
    IESSION_TC AS iso_code,
    CURRDEC AS decimal_places,
    LTEXT AS currency_name_long,
    KTEXT AS currency_name_short
FROM {{ source('sap', 'TCURC') }}
WHERE MANDT = '100'