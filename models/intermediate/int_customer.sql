WITH customer_general AS (
    SELECT * FROM {{ ref('stg_kna1') }}
),

customer_company AS (
    SELECT * FROM {{ ref('stg_knb1') }}
),

customer_sales AS (
    SELECT * FROM {{ ref('stg_knvv') }}
),

addresses AS (
    SELECT * FROM {{ ref('stg_adrc') }}
)

SELECT
    cg.customer_number,
    cg.customer_name,
    cg.customer_name_2,
    cg.country_key,
    cg.city,
    cg.postal_code,
    cg.region,
    cg.street,
    cg.telephone,
    cg.title,
    cg.industry_key,
    cg.account_group,
    cg.tax_number_1,
    cg.vat_registration_no,
    cg.transport_zone,
    cg.customer_classification,
    cg.created_date,
    cg.deletion_flag,

    -- Address details
    addr.name_1 AS address_name,
    addr.city AS address_city,
    addr.postal_code AS address_postal_code,
    addr.street AS address_street,
    addr.house_number AS address_house_number,
    addr.country_key AS address_country,
    addr.time_zone,

    -- Company code data (first company code)
    cc.company_code,
    cc.reconciliation_account,
    cc.accounting_clerk,
    cc.posting_block AS company_posting_block,

    -- Sales area data (first sales area)
    cs.sales_organization,
    cs.distribution_channel,
    cs.division,
    cs.customer_group,
    cs.sales_district,
    cs.price_group,
    cs.incoterms_1,
    cs.incoterms_2,
    cs.payment_terms,
    cs.delivering_plant,
    cs.shipping_conditions,
    cs.currency AS sales_currency

FROM customer_general cg

LEFT JOIN addresses addr
    ON cg.address_number = addr.address_number

LEFT JOIN customer_company cc
    ON cg.customer_number = cc.customer_number

LEFT JOIN customer_sales cs
    ON cg.customer_number = cs.customer_number
