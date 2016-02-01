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
