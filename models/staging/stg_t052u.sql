SELECT
    SPRAS AS language_key,
    ZTERM AS payment_terms_key,
    TEXT1 AS payment_terms_text
FROM {{ source('sap', 'T052U') }}
WHERE MANDT = '100'
