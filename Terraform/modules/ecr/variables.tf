variable "project" {
  description = "Repositório de imagens Docker"
  type        = string
}

variable "services" {
  description = "Lista de serviços para criar repositórios"
  type        = list(string)
}
