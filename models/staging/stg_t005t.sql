SELECT
    SPRAS AS language_key,
    LAND1 AS country_key,
    LANDX AS country_name,
    LANDX50 AS country_name_long
FROM {{ source('sap', 'T005T') }}
WHERE MANDT = '100'
