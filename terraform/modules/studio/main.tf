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

data "twilio_taskrouter_task_channel" "voice_task_channel" {
  workspace_sid = data.twilio_taskrouter_workspaces.workspaces.workspaces[0].sid
  unique_name   = "Voice"
}

resource "twilio_studio_flow" "flow" {
  friendly_name = "[TR Call Redirection] Call Redirection Studio Flow"
  status        = "published"
  definition = jsonencode({
    "description" : "Studio Flow for Call Redirection",
    "states" : [
      {
        "name" : "Trigger",
        "type" : "trigger",
        "transitions" : [
          {
            "event" : "incomingMessage"
          },
          {
            "next" : "send_to_flex_1",
            "event" : "incomingCall"
          },
          {
            "event" : "incomingConversationMessage"
          },
          {
            "event" : "incomingRequest"
          },
          {
            "event" : "incomingParent"
          }
        ],
        "properties" : {
          "offset" : {
            "x" : 0,
            "y" : 0
          }
        }
      },
      {
        "name" : "send_to_flex_1",
        "type" : "send-to-flex",
        "transitions" : [
          {
            "event" : "callComplete"
          },
          {
            "event" : "failedToEnqueue"
          },
          {
            "event" : "callFailure"
          }
        ],
        "properties" : {
          "offset" : {
            "x" : 130,
            "y" : 310
          },
          "workflow" : var.workflows_call_redirection_sid,
          "channel" : data.twilio_taskrouter_task_channel.voice_task_channel.sid
        }
      }
    ],
    "initial_state" : "Trigger",
    "flags" : {
      "allow_concurrent_calls" : true
    }
  })
  validate = true
}
