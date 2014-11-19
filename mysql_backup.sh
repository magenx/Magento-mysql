#!/bin/bash
 
### SYSTEM SETUP ###
BACKUP=/tmp/backup.$$
NOW=$(date +"%d-%m-%Y")
DELDATE=$(date -d "-7 days" +"%d-%m-%Y")
 
### MYSQL SETUP ###
MUSER="xxx"
MPASS="xxx"
MHOST="localhost"
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
GZIP="$(which gzip)"
 
### FTP SETUP ###
FTPD="/backup"
FTPU="xxxxxx"
FTPP="xxxxxx"
FTPS="xxxxxx"
 
### CALLBACK ###
EMAILID="admin@xxxxxx.com"
 
### CREATE BACKUP DIRECTORY ###
[ ! -d ${BACKUP} ] && mkdir -p ${BACKUP} || :

### MYSQLDUMP ###
DBS="$(${MYSQL} -u ${MUSER} -h ${MHOST} -p${MPASS} -Bse 'show databases')"
for db in ${DBS}
do
 FILE=${BACKUP}/mysql-${db}.${NOW}.sql.gz
 ${MYSQLDUMP} -u ${MUSER} -h ${MHOST} -p${MPASS} --single-transaction --routines --triggers  ${db} | ${GZIP} > ${FILE}
done

### FTP UPLOAD ###
ncftp -u ${FTPU} -p ${FTPP} ${FTPS}<<EOF
cd ${FTPD}/${DELDATE}
rm *.gz
cd ${FTPD}
rmdir ${DELDATE}
mkdir ${FTPD}
mkdir ${FTPD}/${NOW}
cd ${FTPD}/${NOW}
lcd ${BACKUP}
mput *
quit
EOF
 
### ALERT IF FAILED ###
if [ "$?" == "0" ]; then
 rm -f ${BACKUP}/*
else
 CALLBACK=/tmp/backup.failed
 echo "Date: ${NOW}">${CALLBACK}
 echo "Hostname: $(hostname)" >>${CALLBACK}
 echo "Backup failed" >>${CALLBACK}
 mail  -s "BACKUP FAILED" "${EMAILID}" <${CALLBACK}
fi
