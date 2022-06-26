{%- macro sumifg(column_name, equal_to, true_value, false_value) -%}

    sum(CASE WHEN {{column_name}} > {{equal_to}}
    THEN {{true_value}} 
    ELSE {{false_value}} 
    END )

{%- endmacro -%}