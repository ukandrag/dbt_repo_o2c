SELECT
    t.payment_terms_key,
    u.payment_terms_text,
    t.discount_percent_1,
    t.discount_days_1,
    t.discount_percent_2,
    t.discount_days_2,
    t.net_payment_days

FROM {{ ref('stg_t052') }} t

LEFT JOIN {{ ref('stg_t052u') }} u
    ON t.payment_terms_key = u.payment_terms_key
    AND u.language_key = 'EN'