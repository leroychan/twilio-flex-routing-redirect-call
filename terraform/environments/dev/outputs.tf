output "TASK_QUEUE_SALES" {
  value       = module.task_queues.task_queue_sales_sid
  description = "SID of Sales Task Queue"
}

output "TASK_QUEUE_SUPPORT" {
  value       = module.task_queues.task_queue_support_sid
  description = "SID of Support Task Queue"
}

output "TASK_QUEUE_EVERYONE" {
  value       = module.task_queues.task_queue_everyone_sid
  description = "SID of Everyone Task Queue"
}

output "TASK_QUEUE_CALL_REDIRECTION" {
  value       = module.task_queues.task_queue_call_redirection_sid
  description = "SID of Call Redirection Task Queue"
}

output "WORKFLOW_CALL_REDIRECTION" {
  value       = module.workflows.workflows_call_redirection_sid
  description = "SID of Call Redirection Workflow"
}

output "FUNCTION_TR_EVENT_CALLBACK_URL" {
  value       = module.functions.function_tr_event_callback_url
  description = "URL of Taskrouter Event Callback"
}

output "FUNCTION_TWIML_REDIRECT_CALL_URL" {
  value       = module.functions.function_twiml_redirect_call_url
  description = "URL of TwiML Redirect Call"
}

output "STUDIO_CALL_REDIRECTION" {
  value       = module.studio.studio_flow_call_redirection_sid
  description = "SID of Studio Flow - Redirect Call"
}
