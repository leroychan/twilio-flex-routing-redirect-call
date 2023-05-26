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

resource "twilio_taskrouter_workflow" "workflow" {
  workspace_sid = data.twilio_taskrouter_workspaces.workspaces.workspaces[0].sid
  friendly_name = "[TR Call Redirection] Call Redirection Workflow"
  configuration = jsonencode({
    "task_routing" : {
      "filters" : [
        {
          "filter_friendly_name" : "Redirect Call",
          "expression" : "1==1",
          "targets" : [
            {
              "queue" : var.task_queue_sales_sid,
              "timeout" : 5
            },
            {
              "queue" : var.task_queue_support_sid,
              "timeout" : 5
            },
            {
              "queue" : var.task_queue_everyone_sid,
              "timeout" : 10
            },
            {
              "queue" : var.task_queue_call_redirection_sid
            }
          ]
        }
      ]
    }
  })
}
