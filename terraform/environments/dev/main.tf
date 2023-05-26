terraform {
  required_providers {
    twilio = {
      source  = "RJPearson94/twilio"
      version = "0.23.0"
    }
  }
}

provider "twilio" {
  account_sid = var.TWILIO_ACCOUNT_SID
  auth_token  = var.TWILIO_AUTH_TOKEN
}

module "task_queues" {
  source = "../../modules/task-queues"
}

module "workflows" {
  source                          = "../../modules/workflows"
  task_queue_sales_sid            = module.task_queues.task_queue_sales_sid
  task_queue_support_sid          = module.task_queues.task_queue_support_sid
  task_queue_everyone_sid         = module.task_queues.task_queue_everyone_sid
  task_queue_call_redirection_sid = module.task_queues.task_queue_call_redirection_sid
}

module "studio" {
  source                         = "../../modules/studio"
  workflows_call_redirection_sid = module.workflows.workflows_call_redirection_sid
}


module "functions" {
  source                          = "../../modules/functions"
  task_queue_call_redirection_sid = module.task_queues.task_queue_call_redirection_sid
  forward_to_number               = var.FORWARD_TO_NUMBER
}

