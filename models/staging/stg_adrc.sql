SELECT
    ADDRNUMBER AS address_number,
    DATE_FROM AS valid_from,
    NAME1 AS name_1,
    NAME2 AS name_2,
    CITY1 AS city,
    POST_CODE1 AS postal_code,
    STREET AS street,
    HOUSE_NUM1 AS house_number,
    COUNTRY AS country_key,
    REGION AS region,
    TIME_ZONE AS time_zone,
    TEL_NUMBER AS telephone,
    FAX_NUMBER AS fax,
    LANGU AS language_key,
    SORT1 AS sort_field_1
FROM {{ source('sap', 'ADRC') }}
WHERE MANDT = '100'