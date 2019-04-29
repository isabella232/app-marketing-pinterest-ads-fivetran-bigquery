view: pinterest_keyword {
  extends: [pinterest_ads_config]
  sql_table_name: {{ pinterest_ads_schema._sql }}.keyword_history ;;

  dimension: ad_group_id {
    type: string
    hidden: yes
  }

  dimension: account_id {
    type: string
    hidden: yes
    sql: ${TABLE}.advertiser_id ;;
  }

  dimension: keyword_id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: keyword {
    type: string
    hidden: no
    sql: ${TABLE}.value ;;
  }

  dimension: match_type {
    hidden: yes
  }

  dimension: parent_type {
    hidden: yes
  }
}

explore: pinterest_keyword_join {
  extension: required

  join: keyword {
    from: pinterest_keyword
    view_label: "Keyword"
    sql_on: ${fact.keyword_id} = ${keyword.keyword_id} AND
      ${fact.ad_group_id} = ${keyword.ad_group_id} AND
      ${fact._date} = ${keyword._date} ;;
    relationship: many_to_one
  }
}
