### FUNCAO DO CODIGO ###
# 1 - criacao da vpc
# 2 - criacao da subnet
# 3 - criacao da internet gateway
# 4 - criacao da route table
# 5 - associa a subnet a route table
# 6 - criacao do security group
# 7 - adiciona regras de entrada no grupo de seguranca


# criacao da vpc
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block_vpc

  tags = {
    Name = "vpc-${var.environment}"
  }
}

# criacao da subnet
resource "aws_subnet" "subnet_terraform" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.cidr_block_subnet
  availability_zone = var.az_subnet

  tags = {
    Name = "subnet-${var.environment}"
  }
}

# criacao da internet gateway
resource "aws_internet_gateway" "igw_terraform" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw-${var.environment}"
  }
}

# criacao da route table
resource "aws_route_table" "rt_terraform" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_terraform.id
  }

  tags = {
    Name = "rtpub-${var.environment}"
  }
}

# associa a subnet a route table
resource "aws_route_table_association" "rt_assoc_terraform" {
  subnet_id      = aws_subnet.subnet_terraform.id
  route_table_id = aws_route_table.rt_terraform.id
}

# criacao do security group
resource "aws_security_group" "sg_terraform" {
  name        = "${var.environment}-sg"
  description = var.descricao_sg
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-sg"
  }
}

# adiciona regras de entrada no grupo de seguranca
resource "aws_security_group_rule" "sgr_ingress" {
  count             = length(var.portas)
  type              = "ingress"
  from_port         = element(var.portas, count.index)
  to_port           = element(var.portas, count.index)
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_terraform.id
}
