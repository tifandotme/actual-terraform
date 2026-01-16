# Cost Analysis

## Setup Overview

- **Platform**: Google Cloud Run (asia-southeast1 region)
- **Allocation**: 1 vCPU, 512Mi RAM (0.5 GiB)
- **Billing**: Request-based (charged only during active requests)
- **Storage**: Google Cloud Storage for SQLite data
- **Domain**: Custom domain via Cloud Run domain mapping

## Free Tier Details

Cloud Run provides a generous free tier for request-based billing:

- **CPU**: First 180,000 vCPU-seconds free/month
- **Memory**: First 360,000 GiB-seconds free/month
- **Requests**: 2 million requests free/month
- **Aggregation**: Across all projects in the billing account, resets monthly.
- **Total free value**: ~$6.05 USD/month equivalent.

With 1 vCPU and 0.5 GiB allocation, plus GCS free tier (5GB storage, 1GB egress):

- Free covers up to ~180,000 seconds (~50 hours) of active run per month.
- Memory free covers up to ~720,000 seconds, but CPU limits first.
- GCS: 5GB free storage, 1GB free egress/month.

## Cost Calculations

### Rates (asia-southeast1, request-based)

- CPU (per vCPU-second) Active time: $0.0000336
- Memory (per GiB-second) Active time: $0.0000035
- Requests (per 1,000,000): $0.40
- GCS Storage: $0.02/GB/month after 5GB free
- GCS Egress: $0.12/GB after 1GB free
- Combined per second: $0.00003535 (0.0000336 + 0.5 × 0.0000035)

### Hypothetical Scenarios

- **24 hours continuous (86,400 seconds)**:
  - vCPU-seconds: 86,400
  - GiB-seconds: 43,200
  - Cost: $3.05424 USD (~$3.05)
  - **Within free tier**: $0 (covered by 180k vCPU-s free)
- **30 days at 24 hours/day**:
  - Total seconds: 2,592,000
  - Cost: ~$91.55 USD after free tier exhaustion
- **Typical usage (low, request-based)**: Minimal cost, mostly free.

## Comparisons to Alternatives

- **Self-hosted on VPS**: $5-20/month for similar specs, but more management.
- **Railway/Render**: Free tier for small apps, then $5-20/month. Similar for light use.
- **AWS (Fargate)**: ~$5-15/month for similar specs. More expensive due to no free tier.
- **Overall**: Cloud Run + GCS is one of the cheapest for personal budgeting, with pay-per-use and auto-scale-to-zero.

## Tips for Cost Control

- **Monitor Usage**: Use GCP Billing console or Cloud Monitoring for real-time metrics.
- **Optimize Requests**: Avoid unnecessary API calls; use caching.
- **Free Tier Awareness**: Current usage (~minimal) is far below limits.
- **Alerts**: Set GCP budget alerts at $20/month.
- **Adjustments**: If needed, reduce CPU/memory in `terraform.tfvars`.
- **GCS**: Monitor storage and egress; use lifecycle policies for old data.

For updates, check GCP pricing and monitor actual usage.
