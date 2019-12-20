###################################
#   REQUIRED VARIABLES
###################################

variable "instance_config" {
  type = object({
    availability_zone 	= string,
    type    			= string,
    name    			= string,
    env     			= string
  })
}

variable "whitelist" {
  description = "This value is used to set a list of IP which will be whitelisted"
  type        = list(any)
}