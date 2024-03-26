#!/bin/bash
set -ex
# Retention policy 60 days, Bucket Lifecycle is a paid solution =(

aws s3 ls ${AWS_ACCESS_BUCKET} | while read -r date time size fileName;
do
  createDate=$(date -d"$date $time" +%s)
  olderThan=$(date -d"-60 days" +%s)

  # not a folder and older than 60 days
  if [[ "$fileName" != */ && $createDate -lt $olderThan ]]; then
    echo "Deleting $fileName"
    aws s3 rm "${AWS_ACCESS_BUCKET}$fileName"
  fi
done

# Get PG_DUMPALL, compress it and store it on AWS with current time as filename
current_time=$(date "+%H-%M-%S-%d-%m-%Y")
# Thinking of adding -c to pg_dumpall to wipe before recreate
pg_dumpall -w -U postgres -h ${HOST} -f /tmp/cnpg-backup.sql
tar -zcvf /tmp/cnpg-backup.tar.gz /tmp/cnpg-backup.sql
aws s3 cp /tmp/cnpg-backup.tar.gz ${AWS_ACCESS_BUCKET}/cnpg-backup-$current_time.tar.gz
