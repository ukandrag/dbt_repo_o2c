SELECT
    p.controlling_area,
    p.profit_center,
    t.profit_center_short_text,
    t.profit_center_long_text,
    p.company_code,
    p.segment,
    p.valid_from,
    p.valid_to,
    p.deletion_flag

FROM {{ ref('stg_cepc') }} p

LEFT JOIN {{ ref('stg_cepct') }} t
    ON p.controlling_area = t.controlling_area
    AND p.profit_center = t.profit_center
    AND p.valid_to = t.valid_to
    AND t.language_key = 'EN'