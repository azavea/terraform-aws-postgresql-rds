#
# Security group resources
#

resource "aws_security_group" "postgresql" {
  name = "database-security-group"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["${var.vpc_cidr_block}"]
  }

  egress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["${var.vpc_cidr_block}"]
  }

  tags {
    Name = "sgDatabaseServer"
  }
}

#
# RDS resources
#

resource "aws_db_instance" "postgresql" {
  allocated_storage = "${var.allocated_storage}"
  engine = "postgres"
  engine_version = "${var.engine_version}"
  identifier = "database"
  instance_class = "${var.instance_type}"
  storage_type = "${var.storage_type}"
  name = "${var.database_name}"
  password = "${var.database_password}"
  username = "${var.database_username}"
  backup_retention_period = "${var.backup_retention_period}"
  backup_window = "${var.backup_window}"
  maintenance_window = "${var.maintenance_window}"
  multi_az = "${var.multi_availability_zone}"
  port = "5432"
  vpc_security_group_ids = ["${aws_security_group.postgresql.id}"]
  db_subnet_group_name = "${aws_db_subnet_group.default.name}"
  parameter_group_name = "${aws_db_parameter_group.default.name}"
  storage_encrypted = "${var.storage_encrypted}"

  tags {
    Name = "DatabaseServer"
  }
}

resource "aws_db_subnet_group" "default" {
  name = "database-subnet-group"
  description = "Private subnets for the RDS instances"
  subnet_ids = ["${split(",", var.private_subnet_ids)}"]

  tags {
    Name = "dbsngDatabaseServer"
  }
}

resource "aws_db_parameter_group" "default" {
  name = "database-parameter-group"
  description = "Parameter group for the RDS instances"
  family = "${var.parameter_group_family}"

  parameter {
    name = "log_min_duration_statement"
    value = "500"
  }
}

#
# CloudWatch resources
#

resource "aws_cloudwatch_metric_alarm" "cpu" {
  alarm_name = "alarmDatabaseServerCPUUtilization"
  alarm_description = "Database server CPU utilization" 
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = "1"
  metric_name = "CPUUtilization"
  namespace = "AWS/RDS"
  period = "300"
  statistic = "Average"
  threshold = "75"
  dimensions {
    DBInstanceIdentifier = "${aws_db_instance.postgresql.id}"
  }
  alarm_actions = ["${split(",", var.alarm_actions)}"]
}

resource "aws_cloudwatch_metric_alarm" "disk_queue" {
  alarm_name = "alarmDatabaseServerDiskQueueDepth"
  alarm_description = "Database server disk queue depth"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = "1"
  metric_name = "DiskQueueDepth"
  namespace = "AWS/RDS"
  period = "60"
  statistic = "Average"
  threshold = "10"
  dimensions {
    DBInstanceIdentifier = "${aws_db_instance.postgresql.id}"
  }
  alarm_actions = ["${split(",", var.alarm_actions)}"]
}

resource "aws_cloudwatch_metric_alarm" "disk_free" {
  alarm_name = "alarmDatabaseServerFreeStorageSpace"
  alarm_description = "Database server free storage space"
  comparison_operator = "LessThanThreshold"
  evaluation_periods = "1"
  metric_name = "FreeStorageSpace"
  namespace = "AWS/RDS"
  period = "60"
  statistic = "Average"
  # 5GB in bytes
  threshold = "5000000000"
  dimensions {
    DBInstanceIdentifier = "${aws_db_instance.postgresql.id}"
  }
  alarm_actions = ["${split(",", var.alarm_actions)}"]
}

resource "aws_cloudwatch_metric_alarm" "memory_free" {
  alarm_name = "alarmDatabaseServerFreeableMemory"
  alarm_description = "Database server freeable memory"
  comparison_operator = "LessThanThreshold"
  evaluation_periods = "1"
  metric_name = "FreeableMemory"
  namespace = "AWS/RDS"
  period = "60"
  statistic = "Average"
  # 128MB in bytes
  threshold = "128000000"
  dimensions {
    DBInstanceIdentifier = "${aws_db_instance.postgresql.id}"
  }
  alarm_actions = ["${split(",", var.alarm_actions)}"]
}
