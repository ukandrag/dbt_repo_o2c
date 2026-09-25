SELECT
    BUKRS AS company_code,
    BUTXT AS company_name,
    ORT01 AS city,
    LAND1 AS country_key,
    WAERS AS local_currency,
    SPRAS AS language_key,
    KTOPL AS chart_of_accounts,
    PERIV AS fiscal_year_variant,
    STCEG AS vat_registration_no,
    ADRNR AS address_number
FROM {{ source('sap', 'T001') }}
WHERE MANDT = '100'