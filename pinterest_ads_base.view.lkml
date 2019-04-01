view: pinterest_ads_base {
  extension: required

  dimension: _fivetran_id {
    hidden: yes
    type: number
    sql: ${TABLE}._fivetran_id ;;
  }

  dimension: _fivetran_synced {
    hidden: yes
    type: date_time
    sql: ${TABLE}._fivetran_synced ;;
    convert_tz: no
  }

  dimension: _date {
    hidden: yes
    type: date_raw
    sql: CAST(${TABLE}.date AS DATE) ;;
  }

  dimension: date_string {
    hidden: yes
    sql: CAST(${TABLE}.date AS STRING) ;;
  }

  dimension: latest {
    hidden: yes
    type: yesno
    sql: 1=1 ;;
  }

  dimension: account_customer_id {
    hidden: yes
    sql: ${TABLE}.advertiser_id ;;
  }

  dimension: account_id_string {
    hidden: yes
    sql: CAST(${TABLE}.advertiser_id as STRING) ;;
  }

}
