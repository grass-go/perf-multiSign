#!/bin/bash

export PATH=$PATH:/usr/local/opt/postgresql/bin
psql=psql
DB="multi_sign"
HOST="123.56.3.74"
PORT="5432"
USER="postgres"
constAddr="TWtWEbY47eZE3TQfaAa7Vj53LV24hki1pf"

ts="2022-07-20 10:29:40"
count=1
for line in `cat /Users/wqq/Text/test_v4.0/perf-multiSign/config/accounts.4000.csv`
do  
    echo ${line}
    addrArray=(${line//,/ })
    echo ${addrArray[0]}
    sqlstr="update multi_tx set threshold=2, current_weight=1, state=0, expire_time='$ts', signers='[{\"u\":\"${addrArray[0]}\",\"w\":1,\"is\":0,\"st\":1626661786000},{\"u\":\"${constAddr}\",\"w\":1,\"is\":0,\"st\":1626661786000}]' where id=$count"
    echo ${sqlstr}
    env PGPASSWORD=1234 psql -h${HOST} -U${USER} -p5432 -d${DB} -c "${sqlstr}"
    count=`expr ${count} + 1`
done

