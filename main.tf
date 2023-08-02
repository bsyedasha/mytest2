terraform {
  required_providers {
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = "0.25.17"
    }
  }

  backend "remote" {
    organization = "practise9"

    workspaces {
      name = "snapi"
    }
  }
}

provider "snowflake" {
}

resource "snowflake_warehouse" "warehouse" {
  count = var.max_cluster_count == null ? 1 : 0

  name           = var.name
  comment        = var.comment
  warehouse_size = var.size

  initially_suspended   = var.initially_suspended
  auto_resume           = var.auto_resume
  auto_suspend          = var.auto_suspend
  wait_for_provisioning = var.wait_for_provisioning

  resource_monitor = var.resource_monitor

  statement_timeout_in_seconds        = var.statement_timeout_in_seconds
  statement_queued_timeout_in_seconds = var.statement_queued_timeout_in_seconds

}

resource "snowflake_database" "demo_db" {
  name    = "DEMO_DB"
  comment = "Database for Snowflake Terraform demo1"
}
