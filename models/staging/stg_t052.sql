SELECT
    ZTERM AS payment_terms_key,
    ZPRZ1 AS discount_percent_1,
    ZTAG1 AS discount_days_1,
    ZPRZ2 AS discount_percent_2,
    ZTAG2 AS discount_days_2,
    ZTAG3 AS net_payment_days
FROM {{ source('sap', 'T052') }}
WHERE MANDT = '100'
