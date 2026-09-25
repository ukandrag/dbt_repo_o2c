SELECT
    CURRKEY AS currency_code,
    CURRDEC AS decimal_places
FROM {{ source('sap', 'TCURX') }}
WHERE MANDT = '100'