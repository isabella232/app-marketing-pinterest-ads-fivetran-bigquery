view: pinterest_ad {
    extends: [pinterest_ads_config]
    sql_table_name: {{ pinterest_ads_schema._sql }}.pin_promotion_history ;;

  dimension: ad_group_id {
    type: string
    hidden: yes
  }

  dimension: ad_id {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.pin_id ;;
  }

  dimension: _date {
    type: date
    hidden: yes
    sql: ${TABLE}.created_time ;;
  }

  dimension: category {
    type: string
    hidden: no
  }

  dimension: type {
    type: string
    hidden: yes
    sql: ${TABLE}.ad_creative_type ;;
  }

  dimension: name {
    type: string
  }

  dimension: display_url {
    type: string
    sql: ${TABLE}.destination_url ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.destination_url ;;
  }
}

  explore: pinterest_ad_join {
    extension: required
    join: ad {
      from: pinterest_ad
      view_label: "Ad"
      sql_on: ${fact.ad_id_string} = ${ad.ad_id} AND
              ${fact.ad_group_id_string} = ${ad.ad_group_id} AND
              ${fact._date} = ${ad._date} ;;
      relationship:  many_to_one
    }

  }
