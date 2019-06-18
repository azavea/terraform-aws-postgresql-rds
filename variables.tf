variable "project" {
  default = "Unknown"
}

variable "environment" {
  default = "Unknown"
}

variable "allocated_storage" {
  default = "32"
}

variable "engine_version" {
  default = "9.5.2"
}

variable "instance_type" {
  default = "db.t2.micro"
}

variable "storage_type" {
  default = "gp2"
}

variable "iops" {
  default = "0"
}

variable "vpc_id" {}

variable "database_identifier" {}

variable "snapshot_identifier" {
  default = ""
}

variable "database_name" {}

variable "database_password" {}

variable "database_username" {}

variable "database_port" {
  default = "5432"
}

variable "backup_retention_period" {
  default = "30"
}

variable "backup_window" {
  # 12:00AM-12:30AM ET
  default = "04:00-04:30"
}

variable "maintenance_window" {
  # SUN 12:30AM-01:30AM ET
  default = "sun:04:30-sun:05:30"
}

variable "auto_minor_version_upgrade" {
  default = true
}

variable "final_snapshot_identifier" {
  default = "terraform-aws-postgresql-rds-snapshot"
}

variable "skip_final_snapshot" {
  default = true
}

variable "copy_tags_to_snapshot" {
  default = false
}

variable "multi_availability_zone" {
  default = false
}

variable "storage_encrypted" {
  default = false
}

variable "monitoring_interval" {
  default = "0"
}

variable "deletion_protection" {
  default = false
}

variable "subnet_group" {}

variable "parameter_group" {
  default = "default.postgres9.4"
}

variable "alarm_cpu_threshold" {
  default = "75"
}

variable "alarm_disk_queue_threshold" {
  default = "10"
}

variable "alarm_free_disk_threshold" {
  # 5GB
  default = "5000000000"
}

variable "alarm_free_memory_threshold" {
  # 128MB
  default = "128000000"
}

variable "alarm_cpu_credit_balance_threshold" {
  default = "30"
}

variable "alarm_actions" {
  type = "list"
}

variable "ok_actions" {
  type = "list"
}

variable "insufficient_data_actions" {
  type = "list"
}
