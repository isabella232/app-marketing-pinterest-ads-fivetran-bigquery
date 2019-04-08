# Views and Explores for pinterest Ads rolled up stats tables

explore: pinterest_ad_impressions_adapter {
  from: pinterest_ad_impressions_adapter
  extends: [pinterest_account_join]
  view_name: fact
  hidden: yes
  group_label: "Pinterest Ads"
  label: "Pinterest Ads Impressions"
  view_label: "Impressions"
}

view: pinterest_ad_impressions_adapter {
  extends: [pinterest_ad_impressions_adapter_base]
  sql_table_name: {{ fact.pinterest_ads_schema._sql }}.advertiser_report ;;
}

view: pinterest_ad_metrics_base_dimensions {
  extension: required

  # Click count is really low compared to other values, testing to see if aggregating multiple click columns creates more realistic values
  dimension: clicks {
    type: number
    sql:  IFNULL(${TABLE}.total_click_page_visit,0) +
          IFNULL(${TABLE}.total_click_add_to_cart,0) +
          IFNULL(${TABLE}.total_click_checkout,0) +
          IFNULL(${TABLE}.total_click_custom,0) +
          IFNULL(${TABLE}.total_click_lead,0) +
          IFNULL(${TABLE}.total_click_search,0) +
          IFNULL(${TABLE}.total_click_signup,0) +
          IFNULL(${TABLE}.total_click_view_category,0) +
          IFNULL(${TABLE}.total_click_watch_video,0)
          ;;
  }

  dimension: conversions {
    type: number
    sql: ${TABLE}.total_conversions;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impression_1 ;;
  }

  dimension: revenue {
    type: number
    sql:${TABLE}.total_conversions_value_in_micro_dollar / 1000000;;
  }

  dimension: spend {
    type: number
    sql: ${TABLE}.spend_in_micro_dollar / 1000000 ;;
  }
}


view: pinterest_ad_impressions_adapter_base {
  extension: required
  extends: [pinterest_ads_config, pinterest_ads_base, pinterest_ad_metrics_base_dimensions]

  dimension: account_id {
    hidden: yes
    type: number
    sql: ${TABLE}.advertiser_id ;;
  }

  dimension: account_id_string {
    hidden: yes
    sql: CAST(${TABLE}.advertiser_id as STRING) ;;
  }

  dimension: network {
    sql: 'NULL' ;;
  }

  dimension: device {
    sql: 'NULL' ;;
  }

}

explore: pinterest_ad_impressions_campaign_adapter {
  extends: [pinterest_ad_impressions_adapter, pinterest_campaign_join]
  from: pinterest_ad_impressions_campaign_adapter
  view_name: fact
  group_label: "Pinterest Ads"
  label: "Pinterest Ads Impressions by Campaign"
  view_label: "Impressions by Campaign"
}


view: pinterest_ad_impressions_campaign_adapter {
  extends: [pinterest_ad_impressions_campaign_adapter_base]
  sql_table_name: {{ fact.pinterest_ads_schema._sql }}.campaign_report ;;
}

view: pinterest_ad_impressions_campaign_adapter_base {
  extends: [pinterest_ad_impressions_adapter_base]

  dimension: campaign_id {
    hidden: yes
    type: number
  }

  dimension: campaign_id_string {
    hidden: yes
    sql: CAST(${TABLE}.campaign_id as STRING) ;;
  }

  dimension_group: date {
    hidden: yes
    type: time
  }
}

explore: pinterest_ad_impressions_ad_group_adapter {
  extends: [pinterest_ad_impressions_adapter, pinterest_ad_group_join]
  from: pinterest_ad_impressions_ad_group_adapter
  view_name: fact
  group_label: "Pinterest Ads"
  label: "Pinterest Ads Impressions by Ad Group"
  view_label: "Impressions by Ad Group"
}

# Was previously extending campaign, but based on Pinterest ERD, advertiser_report branches out into either ad_group or campaign
# Ad_group is not a superset of campaign in pinterest data
view: pinterest_ad_impressions_ad_group_adapter {
#   extension: required
extends: [pinterest_ad_impressions_adapter]
sql_table_name: {{ fact.pinterest_ads_schema._sql }}.ad_group_report ;;

dimension: ad_group_id {
  hidden: yes
  type: number
}

dimension: ad_group_id_string {
  hidden: yes
  sql: CAST(${TABLE}.ad_group_id as STRING) ;;
}

dimension: _date {
  type: date
  sql: ${TABLE}.date ;;
}

}

explore: pinterest_ad_impressions_ad_adapter {
  extends: [pinterest_ad_impressions_ad_group_adapter]
  from: pinterest_ad_impressions_ad_adapter
  view_name: fact
  group_label: "Pinterest Ads"
  label: "Pinterest Ads Impressions by Ad"
  view_label: "Impressions by Ad"
}

view: pinterest_ad_impressions_ad_adapter {
  extends: [pinterest_ad_impressions_ad_group_adapter]
  sql_table_name: {{ fact.pinterest_ads_schema._sql }}.pin_promotion_report ;;

  dimension: ad_id {
    hidden: yes
    type: number
  }

  dimension: ad_id_string {
    hidden: yes
    sql: CAST(${TABLE}.ad_id as STRING) ;;
  }

}

# Keyword components being used as placeholders

explore: pinterest_ad_impressions_keyword_adapter {}

view: pinterest_ad_impressions_keyword_adapter {
  sql_table_name: SELECT 1 ;;
}
