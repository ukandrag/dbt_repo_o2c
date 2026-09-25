SELECT
    MATNR AS material_number,
    ERDAT AS created_date,
    ERNAM AS created_by,
    MTART AS material_type,
    MBRSH AS industry_sector,
    MATKL AS material_group,
    MEINS AS base_unit_of_measure,
    BSTME AS order_unit,
    BRGEW AS gross_weight,
    NTGEW AS net_weight,
    GEWEI AS weight_unit,
    VOLUM AS volume,
    VOLEH AS volume_unit,
    SPART AS division,
    PRDHA AS product_hierarchy,
    EAN11 AS ean_upc,
    LVORM AS deletion_flag,
    MSTAE AS cross_plant_status,
    MHDRZ AS total_shelf_life,
    MHDHB AS remaining_shelf_life
FROM {{ source('sap', 'MARA') }}
WHERE MANDT = '100'
