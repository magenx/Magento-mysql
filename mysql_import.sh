#!/bin/bash

### MySQL Setup ###
MUSER="xxxxxx"
MPASS="xxxxxx"
MHOST="xxxxxx"
MDB="xxxxxx"

### Action ###
read -p "---> Enter MySQL backup gz file name : " MYSQL_BKP_FILE

if [ -e "${MYSQL_BKP_FILE}" ]; then
   echo "Database import"
   zcat ${MYSQL_BKP_FILE} | mysql -f -u ${MUSER} -h ${MHOST} -p${MPASS} ${MDB}
   echo
   echo "Checking MySQL"
   echo
   mysqlcheck -u ${MUSER} -h ${MHOST} -p${MPASS} ${MDB}
   echo
   echo "All done"
else 
   echo "File: ${MYSQL_BKP_FILE} does not exist"
   exit 1
fi
