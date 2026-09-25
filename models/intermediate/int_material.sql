WITH material_general AS (
    SELECT * FROM {{ ref('stg_mara') }}
),

material_text AS (
    SELECT * FROM {{ ref('stg_makt') }}
    WHERE language_key = 'EN'
),

material_plant AS (
    SELECT * FROM {{ ref('stg_marc') }}
)

SELECT
    mg.material_number,
    mt.material_description,
    mg.material_type,
    CASE mg.material_type
        WHEN 'FERT' THEN 'Finished Product'
        WHEN 'HALB' THEN 'Semi-Finished'
        WHEN 'ROH'  THEN 'Raw Material'
        WHEN 'HIBE' THEN 'Operating Supplies'
        WHEN 'DIEN' THEN 'Service'
        ELSE mg.material_type
    END AS material_type_text,
    mg.industry_sector,
    mg.material_group,
    mg.base_unit_of_measure,
    mg.gross_weight,
    mg.net_weight,
    mg.weight_unit,
    mg.volume,
    mg.volume_unit,
    mg.division,
    mg.product_hierarchy,
    mg.ean_upc,
    mg.created_date,
    mg.deletion_flag,
    mg.cross_plant_status,

    -- Plant-level data
    mp.plant,
    mp.mrp_type,
    mp.mrp_controller,
    mp.procurement_type,
    CASE mp.procurement_type
        WHEN 'E' THEN 'In-House Production'
        WHEN 'F' THEN 'External Procurement'
        WHEN 'X' THEN 'Both'
        ELSE mp.procurement_type
    END AS procurement_type_text,
    mp.purchasing_group,
    mp.planned_delivery_days,
    mp.valuation_class

FROM material_general mg

LEFT JOIN material_text mt
    ON mg.material_number = mt.material_number

LEFT JOIN material_plant mp
    ON mg.material_number = mp.material_number
