#!/bin/bash

#   HOW TO ENABLE:
#   chmod +x /root/truncate_logs.sh
#   crontab -l > magecron
#   echo "5 8 * * 6 /bin/bash /root/truncate_logs.sh" >> magecron
#   crontab magecron
#   rm magecron

DB_HOST=""
DB_USER_NAME=""
DB_PASS=""
DB_NAME=""
TABLES="catalog_compare_item dataflow_batch_export dataflow_batch_import log_customer log_visitor log_visitor_info log_url log_url_info log_quote report_viewed_product_index report_compared_product_index report_event"

for table in ${TABLES}
do
  mysql -u ${DB_USER_NAME} -p${DB_PASS} -h ${DB_HOST} ${DB_NAME} -e "TRUNCATE TABLE ${table};"
done
