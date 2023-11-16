variable "tier" {
  type    = string
  default = "WebServer"
}

variable "Env_type" {
  type    = string
  default = "SingleInstance"
}
variable "ebs_stack_name" {
  type    = string
  default = "64bit Amazon Linux 2023 v3.0.0 running .NET 6"
}

variable "app_name" {
  type    = string
  default = "dotnet"
}
variable "EC2KeyName" {
  type    = string
  default = "ebs-key"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "region" {
  type    = string
  default = "eu-west-2"
}

variable "AWS_ACCOUNT" {
  type    = string
  default = "654288531125"
}