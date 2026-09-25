SELECT
    KOKRS AS controlling_area,
    KOSTL AS cost_center,
    DATBI AS valid_to,
    DATAB AS valid_from,
    ERSDA AS created_date,
    BUKRS AS company_code,
    KOSAR AS cost_center_category,
    PRCTR AS profit_center,
    FUNC_AREA AS functional_area,
    LOCK_IND AS lock_indicator
FROM {{ source('sap', 'CSKS') }}
WHERE MANDT = '100'