# Maintenance Notes

## Quick Facts

- Service: `actual-server` (public)
- Image: `actualbudget/actual-server:latest`
- DB: SQLite in GCS bucket
- Secrets: None (data in bucket)
- Terraform dir: `terraform/`
- Deploy: `mise run terraform:deploy`
- Update Actual: Run `mise run terraform:deploy` to update to latest image

## Daily / On-Demand Checks

1. Health: Visit service URL; test budget operations.
2. Logs: `mise run logs`
3. Revisions: Ensure latest is Ready in Cloud Run.
4. Bucket: Check GCS bucket for data integrity.
5. Monitoring: Use GCP Console > Monitoring for metrics/logs.
6. URL: `mise run service-url`
7. Data: Verify SQLite files in bucket.

## Backups & Recovery

- Automated: GCS soft delete (7 days).
- Manual: `mise run backup-data`
- Restore: Run `mise run migrate-data`, then redeploy.
- Test: Periodically verify restores.

## Upgrading Actual

1. Run `mise run terraform:deploy` to update image to latest.
2. Monitor logs; rollback if needed (change image tag in TF, `mise run terraform:deploy`).

## Terraform Workflow

- Remote Backend: State stored in GCS bucket "actual-terraform-state-bucket" with prefix "actual". Created manually.
- Plan: `mise run terraform:plan`
- Apply: `mise run terraform:deploy`
- Validate: `mise run terraform:validate`
- Output URL: `mise run service-url`

## Scaling & Cost Control

- Cloud Run: Adjust max instances, CPU/memory in TF.
- GCS: Low cost; monitor egress.
- Budget Alerts: Set up GCP Billing budgets with alerts.

## Security Hardening

- Least privilege on service accounts.
- Audit logs; HTTPS enforced.
- No secrets needed.

## Troubleshooting

- Image not found: Check public image availability.
- Crashes: Check logs, bucket access.
- Cold starts: Scale-to-zero is fine for low use.

## Disaster Recovery

1. Data loss: Run `mise run migrate-data`.
2. Service broken: Rollback image tag in TF, `mise run terraform:deploy`.

### Test Recovery

- Simulate failures monthly: Mock data loss or service outage.
- Steps: Run `mise run backup-data`, delete resources, `mise run migrate-data`; verify budgets.

## Decommission Checklist

1. Remove public access: Update IAM.
2. Export data: `mise run backup-data`
3. Delete secrets: None.
4. Delete images: N/A.
5. Delete service: `mise run terraform:destroy`
6. Delete bucket: `gcloud storage buckets delete gs://actual-bucket-new`
7. Clean up: GCS state bucket, IAM.

## Weekly Checklist

- Health: Visit URL, test budgets.
- Logs: Check for errors.
- Backups: Confirm recent copies.
- Costs: Monitor GCP billing.

## Notes

- Offline: Export data, delete resources; keep backups.
- Diagnostics: N/A.

## Known Issues

- Cold starts may delay access; acceptable for budgeting app.
