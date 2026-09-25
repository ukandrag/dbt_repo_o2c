SELECT
    t.company_code,
    t.company_name,
    t.city,
    t.country_key,
    ct.country_name,
    t.local_currency,
    t.chart_of_accounts,
    t.fiscal_year_variant,
    t.vat_registration_no

FROM {{ ref('stg_t001') }} t

LEFT JOIN {{ ref('stg_t005t') }} ct
    ON t.country_key = ct.country_key
    AND ct.language_key = 'EN'
