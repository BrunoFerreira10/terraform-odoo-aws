variable "regiao" {
  type        = string
  description = "Região onde a infraestrutura será criada."
}

variable "credential-path" {
  type        = set(string)
  description = "Caminho do arquivo de credenciais"
}

variable "credential-profile" {
  type        = string
  description = "Profile das credenciais"
}

variable "projeto" {
  type        = string
  description = "Autor de edição."
}

variable "cliente" {
  type        = string
  description = "Autor de edição."
}

variable "autor" {
  type        = string
  description = "Autor de edição."
}

variable "remote-state-bucket" {
  type        = string
  description = "Bucket name onde está o remote state"
}

variable "AWS_SSH_PRIVATE_KEY" {
  description = "Chave privada SSH para conexão"
  type        = string  
  sensitive = true
}