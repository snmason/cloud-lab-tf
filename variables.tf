/// variables.tf provides configuration values. 

variable "vpc" {
  type = map(object({
    // Whether VPC is created
    enabled = bool

    cidr = string

    azs = list(string)

    subnet_cidr = object ({
        public = list(string)
        private = list(string)
    }),
    
    single_nat_gateway = bool
  })
  )
  description = "Provides Configuration for VPC"
}

variable "ecs_cluster" {
  type = map(object ({
    enabled = bool
  })
  )
}

variable "tags" {
  type = map(string)
  default = {}
  description = "Tags to be applied to all resources"
}