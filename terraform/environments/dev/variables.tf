variable "TWILIO_ACCOUNT_SID" {
  type        = string
  sensitive   = true
  description = "Twilio Flex Account SID"
}

variable "TWILIO_AUTH_TOKEN" {
  type        = string
  sensitive   = true
  description = "Twilio Flex Account Auth Token"
}

variable "FORWARD_TO_NUMBER" {
  type        = string
  description = "E.164 Number to Forward"
}
