view: pinterest_account {
  extends: [pinterest_ads_config]
  sql_table_name: {{ pinterest_ads_schema._sql }}.advertiser_history ;;

  dimension: account_id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: _date {
    type: date
    sql: ${TABLE}.updated_time ;;
    hidden: yes
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: currency {
    type: string
    hidden: yes
  }

  dimension: country {
    type: string
    hidden: yes
  }

  dimension: owner_user_id {
    type: string
    hidden: yes
  }

  dimension: is_one_tap {
    type: yesno
    hidden: yes
  }

  dimension: test_account {
    type: yesno
    hidden: yes
  }

  dimension: created_time {
    type: date
    hidden: yes
  }
}

explore: pinterest_account_join {
  extension: required

  join: account {
    from: pinterest_account
    view_label: "Account"
    sql_on: ${fact.account_id} = ${account.account_id} AND
      ${fact._date} = ${account._date} ;;
    relationship: many_to_one
  }
}
