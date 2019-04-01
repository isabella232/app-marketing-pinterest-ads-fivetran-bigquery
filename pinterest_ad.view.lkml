view: pinterest_ad {
    extends: [pinterest_ads_config]
    sql_table_name: {{ pinterest_ads_schema._sql }}.pin_history ;;

  dimension: ad_group_id {
    type: string
    hidden: yes
  }

  dimension: ad_id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: _date {
    type: date
    sql: ${TABLE}.created_at ;;
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

  dimension: title {
    type: string
    group_label: "Title"
  }

  dimension: display_url {
    type: string
    sql: ${TABLE}.shareable_url ;;
  }
}

  explore: pinterest_ad_join {
    extension: required

    join: ad {
      from: pinterest_ad
      view_label: "Ads"
      sql_on: ${fact.ad_id} = ${ad.ad_id} AND
              ${fact.ad_group_id} = ${ad.ad_group_id} AND
              ${fact._date} = ${ad._date} ;;
      relationship:  many_to_one
    }
  }
