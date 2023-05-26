terraform {
  required_providers {
    twilio = {
      source  = "RJPearson94/twilio"
      version = "0.23.0"
    }
  }
}

resource "twilio_serverless_service" "service" {
  unique_name   = "tr-call-redirection"
  friendly_name = "[TR Call Redirection] Callback Handler"
}

resource "twilio_serverless_environment" "environment" {
  service_sid = twilio_serverless_service.service.sid
  unique_name = "tr-call-redirection"
}

resource "twilio_serverless_variable" "forward_call_task_queue_sid" {
  service_sid     = twilio_serverless_service.service.sid
  environment_sid = twilio_serverless_environment.environment.sid
  key             = "FORWARD_CALL_TASK_QUEUE_SID"
  value           = var.task_queue_call_redirection_sid
}

resource "twilio_serverless_variable" "forward_to_number" {
  service_sid     = twilio_serverless_service.service.sid
  environment_sid = twilio_serverless_environment.environment.sid
  key             = "FORWARD_TO_NUMBER"
  value           = var.forward_to_number
}

resource "twilio_serverless_asset" "asset" {
  service_sid   = twilio_serverless_service.service.sid
  friendly_name = "helper"
  source        = "../../../function-tr-callback/assets/helper.private.js"
  content_type  = "text/javascript"
  path          = "/helper.js"
  visibility    = "private"
}

resource "twilio_serverless_function" "tr_event_callback" {
  service_sid   = twilio_serverless_service.service.sid
  friendly_name = "tr-event-callback"
  source        = "../../../function-tr-callback/functions/tr-event-callback.protected.js"
  content_type  = "application/javascript"
  path          = "/tr-event-callback"
  visibility    = "protected"
}

resource "twilio_serverless_function" "twiml_redirect_call" {
  service_sid   = twilio_serverless_service.service.sid
  friendly_name = "twiml-redirect-call"
  source        = "../../../function-tr-callback/functions/twiml-redirect-call.js"
  content_type  = "application/javascript"
  path          = "twiml-redirect-call"
  visibility    = "public"
}

resource "twilio_serverless_build" "build" {
  service_sid = twilio_serverless_service.service.sid

  asset_version {
    sid = twilio_serverless_asset.asset.latest_version_sid
  }

  function_version {
    sid = twilio_serverless_function.tr_event_callback.latest_version_sid
  }

  function_version {
    sid = twilio_serverless_function.twiml_redirect_call.latest_version_sid
  }

  dependencies = {
    "@twilio/runtime-handler" = "1.3.0",
    "request"                 = "^2.88.2",
    "request-promise-native"  = "^1.0.9",
    "twilio"                  = "^3.56"
  }

  polling {
    enabled = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "twilio_serverless_deployment" "deployment" {
  service_sid     = twilio_serverless_service.service.sid
  environment_sid = twilio_serverless_environment.environment.sid
  build_sid       = twilio_serverless_build.build.sid

  lifecycle {
    create_before_destroy = true
  }
}
