#!/bin/bash
set -ex
#Retention policy 60 days, Bucket Lifecycle is a paid solution =(
aws s3 ls ${AWS_ACCESS_BUCKET} | while read -r line;
do
  createDate=`echo $line|awk {'print $1" "$2'}`
  createDate=`date -d"$createDate" +%s`
  olderThan=`date -d"-60 days" +%s`
  if [ $createDate -lt $olderThan ]
     then
     fileName=`echo $line|awk {'print $4'}`
     echo $fileName
       if [ $fileName != "" ]
          then
            aws s3 rm ${AWS_ACCESS_BUCKET}$fileName
       fi
  fi
done;

#Get PG_DUMPALL, compress it and store it on AWS with current time as filename
current_time=$(date "+%H-%M-%S-%d-%m-%Y")
pg_dumpall -w -U postgres -h ${HOST} -f /tmp/cnpg-backup.sql
tar -zcvf /tmp/cnpg-backup.tar.gz /tmp/cnpg-backup.sql
aws s3 cp /tmp/cnpg-backup.tar.gz ${AWS_ACCESS_BUCKET}cnpg-backup-$current_time.tar.gz
