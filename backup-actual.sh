#!/bin/bash

cd "$HOME"/backups || exit

echo "$(date): Starting backup" >>actual-backup.log

/opt/homebrew/bin/gsutil cp -r gs://actual-bucket-new/* ./actual-backup-latest/ 2>>actual-backup.log

echo "$(date): Backup completed" >>actual-backup.log
