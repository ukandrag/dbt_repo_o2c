WITH contracts AS (
    SELECT * FROM {{ ref('stg_farr_d_contract') }}
),

pobs AS (
    SELECT * FROM {{ ref('stg_farr_d_pob') }}
),

postings AS (
    SELECT * FROM {{ ref('stg_farr_d_posting') }}
),

order_items AS (
    SELECT * FROM {{ ref('stg_farr_d_order_i') }}
),

invoice_items AS (
    SELECT * FROM {{ ref('stg_farr_d_invoic_i') }}
)

SELECT
    c.contract_id,
    c.contract_type,
    c.customer_number,
    c.contract_start_date,
    c.contract_end_date,
    c.contract_status,
    c.currency AS contract_currency,
    c.company_code,
    c.sales_organization,

    -- POB details
    p.pob_id,
    p.pob_type,
    p.pob_status,
    p.source_type,
    p.source_document,
    p.transaction_price,
    p.allocated_amount,
    p.material_number,

    -- Revenue postings aggregated per POB
    post.posting_date,
    post.posting_amount,
    post.posting_category,
    CASE post.posting_category
        WHEN 'REV' THEN 'Revenue Recognized'
        WHEN 'DEF' THEN 'Deferred Revenue'
        WHEN 'ADJ' THEN 'Adjustment'
        ELSE post.posting_category
    END AS posting_category_text,
    post.gl_account,
    post.cost_center,
    post.profit_center,
    post.posting_period,
    post.posting_year,

    -- Derived
    CASE WHEN c.contract_status = 'ACTIVE' THEN TRUE ELSE FALSE END AS is_active_contract,
    CASE WHEN p.pob_status = 'FULFILLED' THEN TRUE ELSE FALSE END AS is_fulfilled

FROM contracts c

INNER JOIN pobs p
    ON c.contract_id = p.contract_id

LEFT JOIN postings post
    ON p.pob_id = post.pob_id
    AND c.contract_id = post.contract_id
