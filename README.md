# terraform-aws-postgresql-rds

A Terraform module to create an Amazon Web Services (AWS) PostgreSQL Relational Database Server (RDS).

## Usage

```javascript
module "postgresql_rds" {
  source = "github.com/azavea/terraform-aws-postgresql-rds"

  vpc_id = "vpc-20f74844"
  vpc_cidr_block = "10.0.0.0/16"

  allocated_storage = "32"
  engine_version = "9.4.4"
  instance_type = "db.t2.micro"
  storage_type = "gp2"
  database_name = "hector"
  database_username = "hector"
  database_password = "secret"
  backup_retention_period = "30"
  backup_window = "04:00-04:30"
  maintenance_window = "sun:04:30-sun:05:30"
  auto_minor_version_upgrade = false
  multi_availability_zone = true
  storage_encrypted = false

  private_subnet_ids = "subnet-4a887f3c,subnet-76dae35d"
  parameter_group_family = "postgres9.4"

  alarm_actions = "arn:aws:sns..."
  project = "Something"
  environment = "Staging"
}
```

## Variables

- `project` - Name of project this VPC is meant to house (default: `Unknown`)
- `environment` - Name of environment this VPC is targeting (default: `Unknown`)
- `vpc_id` - ID of VPC meant to house database
- `vpc_cidr_block` - CIDR block of VPC
- `allocated_storage` - Storage allocated to database instance (default: `32`)
- `engine_version` - Database engine version (default: `9.4.4`)
- `instance_type` - Instance type for database instance (default: `db.t2.micro`)
- `storage_type` - Type of underlying storage for database (default: `gp2`)
- `database_name` - Name of database inside storage engine
- `database_username` - Name of user inside storage engine
- `database_password` - Database password inside storage engine
- `backup_retention_period` - Number of days to keep database backups (default:
  `30`)
- `backup_window` - 30 minute time window to reserve for backups (default:
  `04:00-04:30`)
- `maintenance_window` - 60 minute time window to reserve for maintenance
  (default: `sun:04:30-sun:05:30`)
- `auto_minor_version_upgrade` - Minor engine upgrades are applied automatically
 to the DB instance during the maintenance window (default: `true`)
- `multi_availability_zone` - Flag to enable hot standby in another availability
  zone (default: `false`)
- `storage_encrypted` - Flag to enable storage encryption (default: `false`)
- `private_subnet_ids` - Comma delimited list of private subnet IDs
- `parameter_group_family` - Database engine parameter group family (default:
  `postgres9.4`)
- `alarm_actions` - Comma delimited list of ARNs to be notified via CloudWatch

## Outputs

- `id` - The database instance ID
- `database_security_group_id` - Security group ID of the database
- `hostname` - Public DNS name of database instance
- `port` - Port of database instance
- `endpoint` - Public DNS name and port separated by a `:`
