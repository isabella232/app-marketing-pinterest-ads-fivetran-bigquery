view: pinterest_ad_group {
  extends: [pinterest_ads_config]
  sql_table_name: {{ pinterest_ads_schema._sql }}.ad_group_history ;;

  dimension: campaign_id {
    type: string
    hidden: yes
  }

  dimension: ad_group_id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: _date {
    type: date
    sql: ${TABLE}.updated_time ;;
    hidden:  yes
  }

  dimension: ad_group_name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: ad_group_status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: bid_type {
    type: string
    hidden: no

  }

  dimension: budget_type {
    type: string
    hidden:  yes
  }


}

explore: pinterest_ad_group_join {
  extension: required

  join: ad_group {
    from: pinterest_ad_group
    view_label: "Ad Group"
    sql_on: ${fact.ad_group_id} = ${ad_group.ad_group_id} AND
      ${fact._date} = ${ad_group._date} ;;
    relationship: many_to_one
  }
}
