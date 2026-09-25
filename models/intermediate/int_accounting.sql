SELECT
    h.company_code,
    h.accounting_document,
    h.fiscal_year,
    l.line_item,
    h.document_type,
    CASE h.document_type
        WHEN 'SA' THEN 'GL Document'
        WHEN 'KR' THEN 'Vendor Invoice'
        WHEN 'DR' THEN 'Customer Invoice'
        WHEN 'DZ' THEN 'Customer Payment'
        WHEN 'KZ' THEN 'Vendor Payment'
        WHEN 'AB' THEN 'Clearing Document'
        ELSE h.document_type
    END AS document_type_text,
    h.document_date,
    h.posting_date,
    h.fiscal_period,
    h.entry_date,
    h.entered_by,
    h.transaction_code,
    h.header_text,
    h.reference_document,
    h.document_currency,
    h.exchange_rate,
    h.document_status,
    h.reversal_document,

    -- Line item details
    l.posting_key,
    l.debit_credit_indicator,
    CASE l.debit_credit_indicator WHEN 'S' THEN 'Debit' WHEN 'H' THEN 'Credit' END AS debit_credit_text,
    l.gl_account,
    l.amount_local_currency,
    l.amount_document_currency,
    l.tax_code,
    l.customer_number,
    l.vendor_number,
    l.cost_center,
    l.profit_center,
    l.sales_document,
    l.purchase_order,
    l.material_number,
    l.business_area,
    l.item_text,
    l.payment_terms,
    l.payment_method,
    l.baseline_payment_date,
    l.clearing_date,
    l.clearing_document,
    l.segment,

    -- Derived amounts
    CASE WHEN l.debit_credit_indicator = 'S' THEN l.amount_local_currency ELSE 0 END AS debit_amount_lc,
    CASE WHEN l.debit_credit_indicator = 'H' THEN l.amount_local_currency ELSE 0 END AS credit_amount_lc

FROM {{ ref('stg_bkpf') }} h

INNER JOIN {{ ref('stg_bseg') }} l
    ON h.company_code = l.company_code
    AND h.accounting_document = l.accounting_document
    AND h.fiscal_year = l.fiscal_year