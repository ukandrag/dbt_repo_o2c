SELECT
    KUNNR AS customer_number,
    PARNR AS contact_person_number,
    NAME1 AS last_name,
    NAMEV AS first_name,
    ANRED AS title,
    ABTNR AS department,
    PAFKT AS contact_function,
    TELF1 AS telephone,
    SMTP_ADDR AS email,
    ERDAT AS created_date,
    ERNAM AS created_by,
    LOEVM AS deletion_flag,
    SEXKZ AS gender_key
FROM {{ source('sap', 'KNVK') }}
WHERE MANDT = '100'