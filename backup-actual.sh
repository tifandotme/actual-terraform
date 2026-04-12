#!/bin/bash
# Cron on macOS often runs with HOME unset; without this, cd to ~/backups fails silently.
set -eo pipefail

export HOME="${HOME:-/Users/$(id -un)}"
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Personal GCP identity for this bucket only (does not change global gcloud default).
export CLOUDSDK_CORE_ACCOUNT="ifan.anvity@gmail.com"

BACKUP_ROOT="${HOME}/backups"
LOG="${BACKUP_ROOT}/actual-backup.log"
DEST="${BACKUP_ROOT}/actual-backup-latest"

mkdir -p "$DEST"
cd "$BACKUP_ROOT"

{
  echo "$(date): Starting backup"
  /opt/homebrew/bin/gsutil -m cp -r "gs://actual-bucket-new/*" "${DEST}/"
  echo "$(date): Backup completed"
} >>"$LOG" 2>&1
