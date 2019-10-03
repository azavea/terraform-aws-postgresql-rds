## 2.8.0

- Add support for publishing logs to CloudWatch Logs.

## 2.7.0

- Add support for instance deletion projection.
- Only set `monitoring_role_arn` if `monitoring_interval` is greater than zero.

## 2.6.0

- Add support for Enhanced Monitoring.

## 2.5.0

- Add support for `iops` to go along with `storage_type`.

## 2.4.0

- Add support for creating an RDS database with `snapshot_identifier`.
- Add support for conditional CPU credit CloudWatch alarms.
- Make Terraform 0.8.x minimum supported version.

## 2.3.0

- Add support for CloudWatch `ok_actions` and `insufficient_data_actions`.

## 2.2.0

- Add support for `hosted_zone_id` output to allow for `ALIAS` DNS record creation.

## 2.1.0

- Add support for triggering a final snapshot with `skip_final_snapshot`.
- Add support for naming the final snapshot with `final_snapshot_identifier` and copying existing tags with `copy_tags_to_snapshot`.

## 2.0.1

- Fix support for `auto_minor_version_upgrade`.

## 2.0.0

- Add support for Terraform 0.7.
- Convert comma-delimited variables with lists types.
- Ensure that numeric variables are strings.

## 1.1.0

- Replace hardcoded database ports with `database_port` variable

## 1.0.0

- Add support for `auto_minor_version_upgrade`.
- Remove security, subnet, and parameter groups.
- Add `database_security_group_id` as output.
- Add support for custom CloudWatch alarm thresholds.

## 0.4.0

- Add database identifier to alarm names to ensure multiple instances do not
  conflict within a single AWS account.

## 0.3.0

- Add RDS instance id in output `id`.

## 0.2.1

- Remove hardcoded identifiers and interpolate `database_name` to create unique
  resource names.

## 0.2.0

- Add support for CloudWatch alarm actions.
- Fix CloudWatch metrics associations with RDS.
- Fix default RDS instance type to `db.t2.micro`.

## 0.1.0

- Initial release.
