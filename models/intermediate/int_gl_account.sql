SELECT
    a.chart_of_accounts,
    a.gl_account,
    t.gl_account_short_text,
    t.gl_account_long_text,
    a.gl_account_group,
    a.balance_sheet_flag,
    CASE WHEN a.balance_sheet_flag = 'X' THEN 'Balance Sheet' ELSE 'P&L' END AS account_type,
    a.functional_area

FROM {{ ref('stg_ska1') }} a

LEFT JOIN {{ ref('stg_skat') }} t
    ON a.chart_of_accounts = t.chart_of_accounts
    AND a.gl_account = t.gl_account
    AND t.language_key = 'EN'