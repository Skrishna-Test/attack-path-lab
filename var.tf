#Required: AWS Profile

#Required: AWS Region
variable "region" {
  default = "us-east-1"
}

#Required: User's Public IP Address(es)
variable "ebilling_whitelist" {
  default = "0.0.0.0/0"
}
#SSH Public Key
variable "ssh-public-key-for-ec2" {
  default = "panw.pub"
}
#SSH Private Key
variable "ssh-private-key-for-ec2" {
  default = "panw"
}
#Stack Name
variable "stack-name" {
  default = "ebilling"
}
#Scenario Name
variable "scenario-name" {
  default = "ebilling-scenario"
}

variable "backend" {
    default = "ebilling"
}