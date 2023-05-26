output "function_tr_event_callback_url" {
  value       = "https://${twilio_serverless_environment.environment.domain_name}${twilio_serverless_function.tr_event_callback.path}"
  description = "URL of the Taskrouter Event Callback function."
}

output "function_twiml_redirect_call_url" {
  value       = "https://${twilio_serverless_environment.environment.domain_name}${twilio_serverless_function.twiml_redirect_call.path}"
  description = "URL of the TwiML Redirect Call function."
}
