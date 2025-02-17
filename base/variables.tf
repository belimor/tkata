variable "ami" {
  default     = "ami-0ed...2279"
  description = "AMI"
  type        = string
  sensitive   = true # don't store var value in the state file

  validation {
    condition     = substr(var.ami, 0, 4) == "ami-"
    error_message = "The ami should start with \"ami-\"."
  }
}

variable "servers" {
  type    = list(any)
  default = ["web0", "web1", "web2"]
}

# var.servers[0]

variable "instance_type" {
  type = map(any)
  default = {
    "production" = "m5.large"
    "dev"        = "t2.small"
  }
}

# var.instance_type["dev"]

variable "servers_list" {
  type    = list(string)
  default = ["web0", "web1", "web2"]
}

variable "servers_numbers" {
  type    = list(number)
  default = [0, 1, 2]
}

variable "instance_type" {
  type = map(string)
  default = {
    "production" = "m5.large"
    "dev"        = "t2.small"
  }
}

# map(number)

variable "servers_numbers_set" {
  type    = set(number)
  default = [0, 1, 2]
}

# set(string)

variable "bella" {
  type = object({
    name         = string
    color        = string
    age          = number
    food         = list(string)
    favorite_pet = bool
  })

  default = {
    name         = "Bella"
    color        = "Black"
    age          = "3"
    food         = ["fish", "chicken", "turkey"]
    favorite_pet = true
  }
}

variable "wev" {
  type    = tuple([string, number, bool])
  default = ["web", 1, true]
}

# types:
# - any
# - string
# - number
# - bool
# - list ### ["a","b"]
# - set
# - map  ### region1 = us-east-1
### region2 = us-east-2
# - object  ### complex data structure
# - tuple   ### complex data structure


