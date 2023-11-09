variable "name" {
  type    = string
  default = "Pendora"
}
variable "app_name" {
  type    = string
  default = "DOT-NET-webAPI-RDS-app"
}

variable "s3_bucket_names" {
  type    = list(any)
  default = ["dev-bucket.app123", "test-bucket.app234", "prod-bucket.app345"]
}

variable "ingress_ports" {
  type    = list(number)
  default = [80, 443]
}

variable "egress_ports" {
  type    = list(number)
  default = [80, 443, 25, 3306, 53, 5503, 8080]
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami" {
  type    = string
  default = "ami-0ad97c80f2dfe623b"

}

variable "vpc_cidr" {
  type    = string
  default = "192.168.0.0/24"
}


variable "region" {
  type    = string
  default = "eu-west-2"
}

variable "web_api_cidr" {
  type    = string
  default = "10.0.0.0/16"
}


variable "sshport" {
  type    = number
  default = 22

}


variable "enabled" {
  default = true
}

variable "mylist" {
  type    = list(string)
  default = ["list-value1", "list-value2"]
}

variable "mymap" {
  type = map(any)
  default = {
    key1 = "map-value1"
    key2 = "map-value2"
    key3 = "map-value3"
  }

}

variable "mytuple" {
  type = tuple([string, number, string])
  default = [
  "cat", 1, "white"]
}

variable "myobject" {
  type = object({ name = string, port = list(number) })
  default = {
    name = "YM"
    port = [22, 80, 443, ]
  }
}