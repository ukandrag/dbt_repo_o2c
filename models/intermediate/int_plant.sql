SELECT
    w.plant,
    w.plant_name,
    w.plant_name_2,
    w.city,
    w.country_key,
    ct.country_name,
    w.region,
    w.company_code,
    w.purchasing_organization

FROM {{ ref('stg_t001w') }} w

LEFT JOIN {{ ref('stg_t005t') }} ct
    ON w.country_key = ct.country_key
    AND ct.language_key = 'EN'