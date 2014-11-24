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
TABLES="log_url log_url_info log_visitor log_visitor_info"

for table in ${TABLES}
do
  mysql -u ${DB_USER_NAME} -p${DB_PASS} -h ${DB_HOST} ${DB_NAME} -e "TRUNCATE TABLE ${table};"
done
