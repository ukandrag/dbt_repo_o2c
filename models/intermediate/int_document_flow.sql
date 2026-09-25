SELECT
    preceding_document,
    preceding_item,
    subsequent_document,
    subsequent_item,
    preceding_doc_category,
    subsequent_doc_category,
    CASE preceding_doc_category
        WHEN 'C' THEN 'Sales Order'
        WHEN 'J' THEN 'Delivery'
        WHEN 'M' THEN 'Invoice'
        WHEN 'R' THEN 'Goods Movement'
        WHEN 'H' THEN 'Return'
        WHEN 'K' THEN 'Credit Memo'
        WHEN 'L' THEN 'Debit Memo'
        ELSE preceding_doc_category
    END AS preceding_doc_type_text,
    CASE subsequent_doc_category
        WHEN 'C' THEN 'Sales Order'
        WHEN 'J' THEN 'Delivery'
        WHEN 'M' THEN 'Invoice'
        WHEN 'R' THEN 'Goods Movement'
        WHEN 'H' THEN 'Return'
        WHEN 'K' THEN 'Credit Memo'
        WHEN 'L' THEN 'Debit Memo'
        ELSE subsequent_doc_category
    END AS subsequent_doc_type_text,
    transferred_quantity,
    transferred_value,
    created_date,
    level AS flow_level

FROM {{ ref('stg_vbfa') }}
