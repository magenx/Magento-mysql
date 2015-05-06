#!/bin/bash
### KILL ALL LONG RUNNING|HEAVY|BAD THREADS
### MySQL Setup
MUSER="xxxxxx"
MPASS="xxxxxx"
MHOST="xxxxxx"
MDB="xxxxxx"
MYSQL="$(which mysql)"

read -p "---> Enter query to kill: " QUERY

for THREAD in $(${MYSQL} -u ${MUSER} -h ${MHOST} -p${MPASS} -e 'show processlist' | grep "${QUERY}" | awk {'print $1'}); do
${MYSQL} -u ${MUSER} -h ${MHOST} -p${MPASS} -e "kill ${THREAD}" &
done
