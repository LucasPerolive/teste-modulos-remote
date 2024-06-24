### FUNCAO DO CODIGO ###
# 1 - define quais serao as variaveis usadas 

##################  main.tf  #########################

# descricao da variavel region
variable "region" {
  description = "regiao onde sera criado os recursos"
}

######################################################

##################  network.tf  ######################

# descricao do cidr_block da vpc
variable "cidr_block_vpc" {
  description = "cidr da vpc"
}

# descricao do nome da vpc
variable "environment" {
  description = "terraform"
}

# decricao do cidr_block da subnet
variable "cidr_block_subnet" {
  description = "cidr da subnet"
}

# descricao da az da subnet
variable "az_subnet" {
  description = "az da subnet"
}

# descricao do sg
variable "descricao_sg" {
  description = "descricao do grupo de seguranca"
}

# portas do sg
variable "portas" {
  description = "portas liberadas para o acesso"
}

######################################################
