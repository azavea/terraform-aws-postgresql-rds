# terraform-aws-postgresql-rds

[![CircleCI](https://circleci.com/gh/azavea/terraform-aws-postgresql-rds.svg?style=svg)](https://circleci.com/gh/azavea/terraform-aws-postgresql-rds)

A Terraform module to create an Amazon Web Services (AWS) PostgreSQL Relational Database Server (RDS).

## Usage

```hcl
module "postgresql_rds" {
  source = "github.com/azavea/terraform-aws-postgresql-rds"
  vpc_id = "vpc-20f74844"
  allocated_storage = "32"
  engine_version = "9.4.4"
  instance_type = "db.t2.micro"
  storage_type = "gp2"
  database_identifier = "jl23kj32sdf"
  database_name = "hector"
  database_username = "hector"
  database_password = "secret"
  database_port = "5432"
  backup_retention_period = "30"
  backup_window = "04:00-04:30"
  maintenance_window = "sun:04:30-sun:05:30"
  auto_minor_version_upgrade = false
  multi_availability_zone = true
  storage_encrypted = false
  subnet_group = aws_db_subnet_group.default.name
  parameter_group = aws_db_parameter_group.default.name
  monitoring_interval = "60"
  deletion_protection = true
  cloudwatch_logs_exports = ["postgresql"]

  alarm_cpu_threshold = "75"
  alarm_disk_queue_threshold = "10"
  alarm_free_disk_threshold = "5000000000"
  alarm_free_memory_threshold = "128000000"
  alarm_actions = ["arn:aws:sns..."]
  ok_actions = ["arn:aws:sns..."]
  insufficient_data_actions = ["arn:aws:sns..."]

  project = "Something"
  environment = "Staging"
}
```

### Note about Enhanced Monitoring support

If the `monitoring_interval` passed as an input to this module is `0`, an empty `monitoring_role_arn` value will be passed to the `aws_db_instance` resource. 

This is because, if a value for `monitoring_role_arn` is passed to an `aws_db_instance`, along with a `monitoring_interval` of `0`, the following error will occur:

```
InvalidParameterCombination: You must specify a MonitoringInterval value other than 0 when you specify a MonitoringRoleARN value.
```

If you're curious to know more, see the discussion within https://github.com/terraform-providers/terraform-provider-aws/issues/315.

## Variables

- `vpc_id` - ID of VPC meant to house database
- `project` - Name of project this VPC is meant to house (default: `Unknown`)
- `environment` - Name of environment this VPC is targeting (default: `Unknown`)
- `allocated_storage` - Storage allocated to database instance (default: `32`)
- `engine_version` - Database engine version (default: `11.5`)
- `instance_type` - Instance type for database instance (default: `db.t3.micro`)
- `storage_type` - Type of underlying storage for database (default: `gp2`)
- `iops` - The amount of provisioned IOPS. Setting this implies a `storage_type` of `io1` (default: `0`)
- `database_identifier` - Identifier for RDS instance
- `snapshot_identifier` - The name of the snapshot (if any) the database should be created from
- `database_name` - Name of database inside storage engine
- `database_username` - Name of user inside storage engine
- `database_password` - Database password inside storage engine
- `database_port` - Port on which database will accept connections (default `5432`)
- `backup_retention_period` - Number of days to keep database backups (default:
  `30`)
- `backup_window` - 30 minute time window to reserve for backups (default:
  `04:00-04:30`)
- `maintenance_window` - 60 minute time window to reserve for maintenance
  (default: `sun:04:30-sun:05:30`)
- `auto_minor_version_upgrade` - Minor engine upgrades are applied automatically
 to the DB instance during the maintenance window (default: `true`)
- `final_snapshot_identifier` - Identifier for final snapshot if `skip_final_snapshot` is set to `false` (default: `terraform-aws-postgresql-rds-snapshot`)
- `skip_final_snapshot` - Flag to enable or disable a snapshot if the database instance is terminated (default: `true`)
- `copy_tags_to_snapshot` - Flag to enable or disable copying instance tags to the final snapshot (default: `false`)
- `multi_availability_zone` - Flag to enable hot standby in another availability
  zone (default: `false`)
- `storage_encrypted` - Flag to enable storage encryption (default: `false`)
- `monitoring_interval` - The interval, in seconds, between points when Enhanced Monitoring metrics are collected (default: `0`)
- `deletion_protection` - Flag to protect the database instance from deletion (default: `false`)
- `cloudwatch_logs_exports` - List of logs to publish to CloudWatch Logs. See [all](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.Concepts.PostgreSQL.html#USER_LogAccess.PostgreSQL.PublishtoCloudWatchLogs) available options. (default: `["postgresql, "upgrade"]`)
- `subnet_group` - Database subnet group
- `parameter_group` - Database engine parameter group (default:
  `default.postgres11`)
- `alarm_cpu_threshold` - CPU alarm threshold as a percentage (default: `75`)
- `alarm_disk_queue_threshold` - Disk queue alarm threshold (default: `10`)
- `alarm_free_disk_threshold` - Free disk alarm threshold in bytes (default: `5000000000`)
- `alarm_free_memory_threshold` - Free memory alarm threshold in bytes (default: `128000000`)
- `alarm_cpu_credit_balance_threshold` - CPU credit balance threshold (default: `30`). Only used for `db.t*` instance types
- `alarm_actions` - List of ARNs to be notified via CloudWatch when alarm enters ALARM state
- `ok_actions` - List of ARNs to be notified via CloudWatch when alarm enters OK state
- `insufficient_data_actions` - List of ARNs to be notified via CloudWatch when alarm enters INSUFFICIENT_DATA state
- `tags` - Extra tags to attach to the RDS resources (default: `{}`)
- `max_allocated_storage` -  is configured, this argument represents the initial storage allocation and differences from the configuration will be ignored automatically when Storage Autoscaling occurs. If replicate_source_db is set, the value is ignored during the creation of the instance.
- `performance_insights_enabled`- (Optional) Specifies whether Performance Insights are enabled. Defaults to false.
- `performance_insights_retention_period` - (Optional) The days to retain backups for. Must be between 0 and 35. Default is 0.
- `performance_insights_kms_key_id` - (Optional) The ARN for the KMS key to encrypt Performance Insights data. When specifying performance_insights_kms_key_id, performance_insights_enabled needs to be set to true. Once KMS key is set, it can never be changed.

## Outputs

- `id` - The database instance ID
- `database_security_group_id` - Security group ID of the database
- `hosted_zone_id` - The zone id for the autogenerated DNS name given in `endpoint`. 
- `hostname` - Public DNS name of database instance
- `port` - Port of database instance
- `endpoint` - Public DNS name and port separated by a colon
   Use this when creating a short-name DNS [alias](https://www.terraform.io/docs/providers/aws/r/route53_record.html#alias-record) for the `endpoint` 
