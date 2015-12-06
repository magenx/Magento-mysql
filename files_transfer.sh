#!/bin/bash
### TRANSFER DATABASE AND FILES FROM REMOTE

TIME=$(date +"%H-%M-%S")
DAY=$(date +"%d-%m-%Y")
FILE=mysql-transfer.${DAY}.${TIME}.sql.gz
OPTIONS="--single-transaction --routines --triggers --events"
MYSQLDATABASE=""
MYSQLUSER=""
MYSQLPASS=""
MYSQLHOST=""
REMOTESERVERIP=""
REMOTEUSER=""
LOCALUSER=""
REMOTEPATH="/var/www/html/magento/"
LOCALPATH="/var/www/html/magento/"
EXCLUDEFROM="/root/exclude.txt"

echo "RSYNC FILES FROM REMOTE SERVER"
rsync -vrltpD --exclude-from=${EXCLUDEFROM} ${REMOTEUSER}@${REMOTESERVERIP}:${REMOTEPATH} ${LOCALPATH}
chown -R ${LOCALUSER}:${LOCALUSER} ${LOCALPATH}
echo "<<<   ----   done   ----   >>>"

echo "MYSQLDUMP ON REMOTE SERVER"
ssh ${REMOTEUSER}@${REMOTESERVERIP} "mysqldump -u ${MYSQLUSER} -h ${MYSQLHOST} -p${MYSQLPASS} ${OPTIONS} ${MYSQLDATABASE} | gzip > ${REMOTEPATH}${FILE}"

rsync -avz --remove-source-files ${REMOTEUSER}@${REMOTESERVERIP}:${REMOTEPATH}${FILE} .

echo "DATABASE IMPORT. PLEASE WAIT."
zcat ${FILE} | mysql -f ${MYSQLDATABASE}

mysqlcheck ${MYSQLDATABASE}

echo
echo "<<<   ----   done   ----   >>>"
