view: pinterest_ad {
    extends: [pinterest_ads_config]
    sql_table_name: {{ pinterest_ads_schema._sql }}.pin_promotion_history ;;

  dimension: ad_group_id {
    type: string
    hidden: yes
    sql: CAST(${TABLE}.ad_group_id AS STRING) ;;
  }

  dimension: ad_id {
    primary_key: yes
    hidden: yes
    sql: CAST(${TABLE}.id AS STRING);;
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

  dimension: creative_final_urls {
    type: string
    hidden:  yes
    sql: ${TABLE}.destination_url ;;
  }

  dimension: creative_final_urls_clean {
    hidden: yes
    type: string
    sql: REGEXP_EXTRACT(${creative_final_urls}, r'\"([^\"]*)\"') ;;
  }

  dimension: display_url {
    label: "Destination Url"
    type: string
    sql: SUBSTR(REGEXP_EXTRACT(${creative_final_urls}, r'^https?:\/\/(.*)\?'), 0, 50) ;;
    link: {
      url: "{{ creative_final_urls_clean }}"
      label: "Landing Page"
    }
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
