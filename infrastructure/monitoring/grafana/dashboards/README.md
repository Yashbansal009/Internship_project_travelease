# Grafana Dashboards

This directory is for storing custom Grafana dashboard JSON files. Any dashboard JSON placed here will be automatically loaded into Grafana when the container starts (see docker-compose.yml volume mount).

## How to Use

1. Create or customize dashboards in the Grafana web UI.
2. Export the dashboard as JSON (`Dashboard settings > JSON model > Export`).
3. Save the exported file in this directory (e.g., `default.json`, `booking-service.json`).
4. Restart the Grafana container to load new dashboards.

## Example

- `default.json`: Basic service monitoring dashboard
- `booking-service.json`: Dashboard for booking-service metrics
- `payment-service.json`: Dashboard for payment-service metrics

## Best Practices

- Name dashboard files after the service or purpose for clarity.
- Keep dashboards under version control for team collaboration.
- Update dashboards as your metrics and services evolve.

## References

- [Grafana Documentation](https://grafana.com/docs/grafana/latest/dashboards/export-import/)
