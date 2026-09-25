WITH sales_orders AS (
    SELECT * FROM {{ ref('int_sales_order') }}
),

doc_flow AS (
    SELECT * FROM {{ ref('int_document_flow') }}
),

billing AS (
    SELECT * FROM {{ ref('int_billing') }}
),

accounting AS (
    SELECT * FROM {{ ref('int_accounting') }}
    WHERE customer_number IS NOT NULL
),

customers AS (
    SELECT * FROM {{ ref('int_customer') }}
),

materials AS (
    SELECT * FROM {{ ref('int_material') }}
),

company_codes AS (
    SELECT * FROM {{ ref('int_company_code') }}
),

payment_terms AS (
    SELECT * FROM {{ ref('int_payment_terms') }}
)

SELECT
    -- Order identifiers
    so.sales_document,
    so.item_number AS order_item,
    so.document_type,
    so.document_type_text,
    so.created_date AS order_created_date,
    so.document_date AS order_date,
    so.purchase_order_number,

    -- Customer
    so.customer_number,
    cust.customer_name,
    cust.country_key AS customer_country,
    cust.city AS customer_city,
    cust.industry_key,

    -- Sales org
    so.sales_organization,
    so.distribution_channel,
    so.division,
    so.document_currency,

    -- Material
    so.material_number,
    mat.material_description,
    mat.material_type,
    mat.material_type_text,
    mat.material_group,
    so.item_description,

    -- Order amounts
    so.order_quantity,
    so.sales_unit,
    so.net_price,
    so.item_net_value AS order_item_value,
    so.order_net_value,
    so.plant,

    -- Order status
    so.item_overall_status,
    so.item_delivery_status,
    so.item_billing_status,
    so.order_overall_status,
    so.order_credit_status,
    so.is_rejected,
    so.is_delivery_blocked,
    so.is_billing_blocked,

    -- Billing (via document flow: order -> billing)
    df_bill.subsequent_document AS billing_document,
    bill.billing_date,
    bill.billing_type,
    bill.billing_type_text,
    bill.item_net_value AS billed_value,
    bill.item_tax_amount AS billed_tax,
    bill.billed_quantity,
    bill.company_code AS billing_company_code,
    bill.is_cancelled AS billing_cancelled,

    -- Company code
    cc.company_name,
    cc.local_currency,

    -- Payment terms
    so.payment_terms AS payment_terms_key,
    pt.payment_terms_text,
    pt.net_payment_days,
    pt.discount_percent_1,
    pt.discount_days_1,

    -- Accounting (via billing doc -> FI doc)
    acct.accounting_document,
    acct.posting_date AS accounting_posting_date,
    acct.document_type AS fi_document_type,
    acct.gl_account,
    acct.amount_local_currency AS accounting_amount_lc,

    -- O2C lifecycle metrics
    DATEDIFF('day', so.created_date, bill.billing_date) AS order_to_billing_days,
    DATEDIFF('day', bill.billing_date, acct.posting_date) AS billing_to_posting_days,
    DATEDIFF('day', so.created_date, acct.posting_date) AS order_to_posting_days,

    -- Fulfillment rate
    CASE
        WHEN so.order_quantity > 0 AND bill.billed_quantity IS NOT NULL
        THEN ROUND(bill.billed_quantity / so.order_quantity * 100, 2)
        ELSE NULL
    END AS fulfillment_rate_pct

FROM sales_orders so

-- Customer dimension
LEFT JOIN customers cust
    ON so.customer_number = cust.customer_number

-- Material dimension
LEFT JOIN materials mat
    ON so.material_number = mat.material_number

-- Document flow: Order -> Billing
LEFT JOIN doc_flow df_bill
    ON so.sales_document = df_bill.preceding_document
    AND so.item_number = df_bill.preceding_item
    AND df_bill.subsequent_doc_category = 'M'

-- Billing fact
LEFT JOIN billing bill
    ON df_bill.subsequent_document = bill.billing_document
    AND so.item_number = bill.item_number

-- Company code dimension
LEFT JOIN company_codes cc
    ON bill.company_code = cc.company_code

-- Payment terms dimension
LEFT JOIN payment_terms pt
    ON so.payment_terms = pt.payment_terms_key

-- Accounting fact (via customer on FI doc)
LEFT JOIN accounting acct
    ON so.customer_number = acct.customer_number
    AND acct.company_code = bill.company_code
    AND acct.fiscal_year = bill.fiscal_year
