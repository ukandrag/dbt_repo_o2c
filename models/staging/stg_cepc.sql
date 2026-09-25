SELECT
    PRCTR AS profit_center,
    DATBI AS valid_to,
    DATAB AS valid_from,
    KOKRS AS controlling_area,
    BUKRS AS company_code,
    ERSDA AS created_date,
    USNAM AS created_by,
    SEGMENT AS segment,
    LOCK_IND AS lock_indicator,
    LOEVM AS deletion_flag
FROM {{ source('sap', 'CEPC') }}
WHERE MANDT = '100'
