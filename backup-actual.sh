#!/bin/bash
# Cron on macOS often runs with HOME unset; without this, cd to ~/backups fails silently.
set -eo pipefail

export HOME="${HOME:-/Users/$(id -un)}"
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Official pattern: session-only active configuration (does not change global default).
# https://cloud.google.com/sdk/docs/configurations
# https://cloud.google.com/sdk/gcloud/reference/topic/startup (CLOUDSDK_ACTIVE_CONFIG_NAME)
GCLOUD="/opt/homebrew/bin/gcloud"
CONFIG_NAME="actual"
export CLOUDSDK_ACTIVE_CONFIG_NAME="${CONFIG_NAME}"

BACKUP_ROOT="${HOME}/backups"
LOG="${BACKUP_ROOT}/actual-backup.log"
DEST="${BACKUP_ROOT}/actual-backup-latest"

mkdir -p "$DEST"
cd "$BACKUP_ROOT"

{
  echo "$(date): Starting backup"
  if ! "$GCLOUD" config configurations list --format='value(name)' 2>/dev/null | grep -qxF "$CONFIG_NAME"; then
    echo "$(date): ERROR: gcloud configuration '${CONFIG_NAME}' not found."
    echo "Create it (names must match CONFIG_NAME in this script):"
    echo "  gcloud config configurations create ${CONFIG_NAME}"
    echo "  gcloud config set account YOUR_PERSONAL_GMAIL"
    echo "  gcloud config set project YOUR_PROJECT_ID"
    exit 1
  fi
  /opt/homebrew/bin/gsutil -m cp -r "gs://actual-bucket-new/*" "${DEST}/"
  echo "$(date): Backup completed"
} >>"$LOG" 2>&1
