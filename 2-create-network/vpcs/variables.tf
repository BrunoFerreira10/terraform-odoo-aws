variable "allowed-iplist" {
  description = "IPs que tem acesso remoto na infraestrutura"
  type        = set(string)
}

variable "vpc-1-name" {
  type = string
}