terraform {
  required_providers {
    twilio = {
      source  = "RJPearson94/twilio"
      version = "0.23.0"
    }
  }
}

# Obtain Default TaskRouter Workspace SID
data "twilio_taskrouter_workspaces" "workspaces" {
  friendly_name = "Flex Task Assignment"
}

resource "twilio_taskrouter_task_queue" "task_queue_sales" {
  workspace_sid = data.twilio_taskrouter_workspaces.workspaces.workspaces[0].sid
  friendly_name = "[TR Call Redirection] Sales"
}

resource "twilio_taskrouter_task_queue" "task_queue_support" {
  workspace_sid = data.twilio_taskrouter_workspaces.workspaces.workspaces[0].sid
  friendly_name = "[TR Call Redirection] Support"
}

resource "twilio_taskrouter_task_queue" "task_queue_everyone" {
  workspace_sid = data.twilio_taskrouter_workspaces.workspaces.workspaces[0].sid
  friendly_name = "[TR Call Redirection] Everyone"
}

resource "twilio_taskrouter_task_queue" "task_queue_call_redirection" {
  workspace_sid  = data.twilio_taskrouter_workspaces.workspaces.workspaces[0].sid
  friendly_name  = "[TR Call Redirection] Call Redirection"
  target_workers = "1==2"
}
