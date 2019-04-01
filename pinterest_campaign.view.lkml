view: pinterest_campaign {
extends: [pinterest_ads_config]
  sql_table_name: {{ pinterest_ads_schema._sql }}.campaign_history ;;

  dimension: account_id {
    type: string
    hidden: yes
    sql: ${TABLE}.advertiser_id ;;
  }

  dimension: campaign_id {
    type: string
    primary_key: yes
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: _date {
    type: date
    sql: ${TABLE}.updated_time ;;
    hidden: yes
  }

  dimension: billing_group {
    type: string
    hidden: yes
  }

  dimension: campaign_name {
    type: string
    hidden: no
    sql: ${TABLE}.name ;;
  }

  dimension: campaign_status {
    type: string
    hidden: no
    sql: ${TABLE}.status ;;
  }

  dimension: optimization_goal {
    type: string
    hidden: yes
  }

  dimension: type {
    type: string
    hidden: yes
    sql: ${TABLE}.campaign_type ;;
  }
}

explore: pinterest_campaign_join {
  extension: required

  join: campaign {
    from: pinterest_campaign
    view_label: "Campaign"
    sql_on: ${fact.campaign_id} = ${campaign.campaign_id} AND
      ${fact.account_id} = ${campaign.account_id} AND
      ${fact._date} = ${campaign._date} ;;
    relationship: many_to_one
  }
}
