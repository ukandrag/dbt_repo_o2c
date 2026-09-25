{% macro sap_currency_fix(
    p_amount_column, tcurx_ref=ref("stg_tcurx")
) %}
    cast(
        {{ p_amount_column }} * power(
            10, coalesce(cast({{ tcurx_ref }}.decimal_places as integer), 2) - 2
        ) as decimal(18, 4)
    )
{% endmacro %}
