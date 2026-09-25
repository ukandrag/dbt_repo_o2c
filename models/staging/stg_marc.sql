SELECT
    MATNR AS material_number,
    WERKS AS plant,
    DISMM AS mrp_type,
    DISPO AS mrp_controller,
    BESKZ AS procurement_type,
    EKGRP AS purchasing_group,
    PLIFZ AS planned_delivery_days,
    WEBAZ AS goods_receipt_processing_days,
    PERKZ AS period_indicator,
    LOSGR AS lot_size,
    BKLAS AS valuation_class,
    MTVFP AS availability_check_group,
    LVORM AS deletion_flag
FROM {{ source('sap', 'MARC') }}
WHERE MANDT = '100'