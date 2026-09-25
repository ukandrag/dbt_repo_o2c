
{{ config(materialized='semantic_view') }}

TABLES (

    o2c AS {{ ref('fct_order_to_cash') }}

        PRIMARY KEY (sales_document, order_item)

)

FACTS (

    o2c.order_to_billing_days AS o2c.order_to_billing_days
        COMMENT = 'Days from order creation to billing',

    o2c.billing_to_posting_days AS o2c.billing_to_posting_days
        COMMENT = 'Days from billing to FI posting',

    o2c.order_to_posting_days AS o2c.order_to_posting_days
        COMMENT = 'Days from order creation to FI posting (full O2C cycle)',

    o2c.fulfillment_rate_pct AS o2c.fulfillment_rate_pct
        COMMENT = 'Percentage of ordered quantity that was billed'

)

DIMENSIONS (

    o2c.sales_document AS o2c.sales_document
        WITH SYNONYMS = ('sales order', 'order number'),

    o2c.order_item AS o2c.order_item
        WITH SYNONYMS = ('line item'),

    o2c.document_type AS o2c.document_type
        WITH SYNONYMS = ('order type'),

    o2c.document_type_text AS o2c.document_type_text,

    o2c.order_created_date AS o2c.order_created_date
        WITH SYNONYMS = ('order creation date'),

    o2c.order_date AS o2c.order_date
        WITH SYNONYMS = ('document date'),

    o2c.purchase_order_number AS o2c.purchase_order_number
        WITH SYNONYMS = ('PO number', 'customer PO'),

    o2c.customer_number AS o2c.customer_number
        WITH SYNONYMS = ('customer id', 'sold-to party'),

    o2c.customer_name AS o2c.customer_name
        WITH SYNONYMS = ('client name', 'account name'),

    o2c.customer_country AS o2c.customer_country
        WITH SYNONYMS = ('country'),

    o2c.customer_city AS o2c.customer_city
        WITH SYNONYMS = ('city'),

    o2c.industry_key AS o2c.industry_key
        WITH SYNONYMS = ('industry'),

    o2c.sales_organization AS o2c.sales_organization
        WITH SYNONYMS = ('sales org'),

    o2c.distribution_channel AS o2c.distribution_channel
        WITH SYNONYMS = ('channel'),

    o2c.division AS o2c.division,

    o2c.document_currency AS o2c.document_currency
        WITH SYNONYMS = ('currency'),

    o2c.material_number AS o2c.material_number
        WITH SYNONYMS = ('material id', 'product number'),

    o2c.material_description AS o2c.material_description
        WITH SYNONYMS = ('product name'),

    o2c.material_type AS o2c.material_type,

    o2c.material_type_text AS o2c.material_type_text,

    o2c.material_group AS o2c.material_group,

    o2c.item_description AS o2c.item_description,

    o2c.sales_unit AS o2c.sales_unit
        WITH SYNONYMS = ('unit of measure'),

    o2c.plant AS o2c.plant,

    o2c.item_overall_status AS o2c.item_overall_status,

    o2c.item_delivery_status AS o2c.item_delivery_status,

    o2c.item_billing_status AS o2c.item_billing_status,

    o2c.order_overall_status AS o2c.order_overall_status,

    o2c.order_credit_status AS o2c.order_credit_status,

    o2c.is_rejected AS o2c.is_rejected,

    o2c.is_delivery_blocked AS o2c.is_delivery_blocked,

    o2c.is_billing_blocked AS o2c.is_billing_blocked,

    o2c.billing_document AS o2c.billing_document
        WITH SYNONYMS = ('invoice number'),

    o2c.billing_date AS o2c.billing_date
        WITH SYNONYMS = ('invoice date'),

    o2c.billing_type AS o2c.billing_type,

    o2c.billing_type_text AS o2c.billing_type_text,

    o2c.billing_company_code AS o2c.billing_company_code,

    o2c.billing_cancelled AS o2c.billing_cancelled,

    o2c.company_name AS o2c.company_name,

    o2c.local_currency AS o2c.local_currency,

    o2c.payment_terms_key AS o2c.payment_terms_key
        WITH SYNONYMS = ('payment terms'),

    o2c.payment_terms_text AS o2c.payment_terms_text,

    o2c.accounting_document AS o2c.accounting_document
        WITH SYNONYMS = ('FI document'),

    o2c.accounting_posting_date AS o2c.accounting_posting_date,

    o2c.fi_document_type AS o2c.fi_document_type,

    o2c.gl_account AS o2c.gl_account
        WITH SYNONYMS = ('general ledger account')

)

METRICS (

    o2c.total_order_value AS SUM(o2c.order_net_value)
        WITH SYNONYMS = ('total sales', 'total order amount'),

    o2c.total_billed_value AS SUM(o2c.billed_value)
        WITH SYNONYMS = ('total invoiced', 'total billing amount'),

    o2c.total_billed_tax AS SUM(o2c.billed_tax)
        WITH SYNONYMS = ('total tax'),

    o2c.total_order_item_value AS SUM(o2c.order_item_value)
        WITH SYNONYMS = ('total line item value'),

    o2c.total_accounting_amount AS SUM(o2c.accounting_amount_lc)
        WITH SYNONYMS = ('total posted amount'),

    o2c.order_count AS COUNT(o2c.sales_document)
        WITH SYNONYMS = ('number of orders'),

    o2c.avg_order_to_billing AS AVG(o2c.order_to_billing_days)
        WITH SYNONYMS = ('average order to billing cycle time'),

    o2c.avg_order_to_posting AS AVG(o2c.order_to_posting_days)
        WITH SYNONYMS = ('average O2C cycle time', 'average order to cash'),

    o2c.avg_fulfillment_rate AS AVG(o2c.fulfillment_rate_pct)
        WITH SYNONYMS = ('average fill rate'),

    o2c.avg_net_payment_days AS AVG(o2c.net_payment_days)
        WITH SYNONYMS = ('average payment terms'),

    o2c.avg_discount_pct AS AVG(o2c.discount_percent_1)
        WITH SYNONYMS = ('average early payment discount')

)

COMMENT = 'Order-to-Cash lifecycle semantic view for Cortex Analyst - tracks orders from creation through billing and accounting with cycle time metrics'