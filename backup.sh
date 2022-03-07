#!/bin/bash

##### VARIABLES
USER='dbuser'
PASSWORD='dbpassword'
DB_NAME='dbname'
DATE=$(date +"%Y%m%d-%H%M")
BACKUP_LOCATION="/backups/mysql"
BACKUP_NAME="${BACKUP_LOCATION}/${DATE}.gz"

# backup
mysqldump --single-transaction --quick --lock-tables=false --user=$USER --password=$PASSWORD $DB_NAME | gzip > $BACKUP_NAME

# send to s3
aws s3 cp $BACKUP_NAME s3://S3_BUCKET/FOLDER/`date +%Y`/`date +%m`/`date +%d`/
rm $BACKUP_NAME
