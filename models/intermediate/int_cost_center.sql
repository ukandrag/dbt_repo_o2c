SELECT
    c.controlling_area,
    c.cost_center,
    t.cost_center_short_text,
    t.cost_center_long_text,
    c.company_code,
    c.cost_center_category,
    CASE c.cost_center_category
        WHEN 'H' THEN 'Overhead'
        WHEN 'E' THEN 'Production'
        WHEN 'F' THEN 'R&D'
        WHEN 'P' THEN 'Admin'
        ELSE c.cost_center_category
    END AS category_text,
    c.profit_center,
    c.functional_area,
    c.valid_from,
    c.valid_to

FROM {{ ref('stg_csks') }} c

LEFT JOIN {{ ref('stg_cskt') }} t
    ON c.controlling_area = t.controlling_area
    AND c.cost_center = t.cost_center
    AND c.valid_to = t.valid_to
    AND t.language_key = 'EN'