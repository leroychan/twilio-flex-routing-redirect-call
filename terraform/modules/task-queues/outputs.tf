output "task_queue_sales_sid" {
  value       = twilio_taskrouter_task_queue.task_queue_sales.id
  description = "Task Queue - Sales SID"
}

output "task_queue_support_sid" {
  value       = twilio_taskrouter_task_queue.task_queue_support.id
  description = "Task Queue - Support SID"
}

output "task_queue_everyone_sid" {
  value       = twilio_taskrouter_task_queue.task_queue_everyone.id
  description = "Task Queue - Everyone SID"
}

output "task_queue_call_redirection_sid" {
  value       = twilio_taskrouter_task_queue.task_queue_call_redirection.id
  description = "Task Queue - Call Redirection SID"
}
