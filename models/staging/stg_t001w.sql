SELECT
    WERKS AS plant,
    NAME1 AS plant_name,
    NAME2 AS plant_name_2,
    STRAS AS street,
    PSTLZ AS postal_code,
    ORT01 AS city,
    LAND1 AS country_key,
    REGIO AS region,
    BUKRS AS company_code,
    EKORG AS purchasing_organization,
    SPRAS AS language_key
FROM {{ source('sap', 'T001W') }}
WHERE MANDT = '100'