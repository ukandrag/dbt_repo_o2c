SELECT
    h.billing_document,
    i.item_number,
    h.billing_type,
    h.billing_category,
    h.billing_date,
    h.created_date,
    h.company_code,
    h.sales_organization,
    h.distribution_channel,
    h.division,
    h.document_currency,
    h.payer,
    h.sold_to_party AS customer_number,
    h.payment_terms,
    h.fiscal_year,
    h.accounting_document,
    h.reference_document,
    h.cancelled_flag,
    h.country_key,
    h.exchange_rate,

    -- Item details
    i.material_number,
    i.item_description,
    i.item_category,
    i.billed_quantity,
    i.sales_unit,
    i.net_value AS item_net_value,
    i.tax_amount AS item_tax_amount,
    i.plant,
    i.material_group,
    i.product_hierarchy,
    i.sales_order,
    i.sales_order_item,
    i.profit_center,
    i.cost_center,
    i.business_area,
    i.subtotal_1,
    i.cost_value,

    -- Header totals
    h.net_value AS billing_net_value,
    h.tax_amount AS billing_tax_amount,
    h.net_value + h.tax_amount AS billing_gross_value,

    -- Derived
    CASE WHEN h.cancelled_flag = 'X' THEN TRUE ELSE FALSE END AS is_cancelled,
    CASE h.billing_type
        WHEN 'F2' THEN 'Invoice'
        WHEN 'RE' THEN 'Credit Memo'
        WHEN 'L2' THEN 'Debit Memo'
        WHEN 'S1' THEN 'Cancellation'
        ELSE h.billing_type
    END AS billing_type_text

FROM {{ ref('stg_vbrk') }} h

INNER JOIN {{ ref('stg_vbrp') }} i
    ON h.billing_document = i.billing_document
