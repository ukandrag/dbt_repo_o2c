SELECT
    c.currency_code,
    c.iso_code,
    c.currency_name_long,
    c.currency_name_short,

    -- TCURX is the authoritative source for decimal precision
    -- SAP stores amounts shifted by (2 - CURRDEC) decimal places
    -- e.g., JPY (0 decimals): amount stored as-is, USD (2 decimals): standard
    COALESCE(x.decimal_places, c.decimal_places) AS decimal_places,
    POWER(10, 2 - COALESCE(x.decimal_places, c.decimal_places)) AS decimal_shift_factor,

    r.exchange_rate AS rate_to_usd,
    r.valid_from_date AS rate_valid_from

FROM {{ ref('stg_tcurc') }} c

-- TCURX: currency decimal places (authoritative for amount conversion)
LEFT JOIN {{ ref('stg_tcurx') }} x
    ON c.currency_code = x.currency_code

LEFT JOIN (
    SELECT
        from_currency,
        to_currency,
        valid_from_date,
        exchange_rate,
        ROW_NUMBER() OVER (
            PARTITION BY from_currency, to_currency
            ORDER BY valid_from_date DESC
        ) AS rn
    FROM {{ ref('stg_tcurr') }}
    WHERE rate_type = 'M'
      AND to_currency = 'USD'
) r
    ON c.currency_code = r.from_currency
    AND r.rn = 1
