SELECT
    KUNNR AS customer_number,
    VKORG AS sales_organization,
    VTWEG AS distribution_channel,
    SPART AS division,
    PARVW AS partner_function,
    KUNN2 AS partner_customer_number,
    LIFNR AS vendor_number,
    PERNR AS personnel_number,
    PARNR AS contact_person_number,
    DEFPA AS default_partner,
    LOEVM AS deletion_flag,
    ERDAT AS created_date
FROM {{ source('sap', 'KNVP') }}
WHERE MANDT = '100'