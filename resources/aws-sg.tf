resource "aws_security_group" "instancesWeb" {
  name        = "${var.project}-${terraform.workspace}-instancesWeb-sg"
  description = "${var.project}-${terraform.workspace} SG instancesWeb"
  vpc_id      = aws_vpc.vpc.id
    dynamic "ingress" {
        for_each = local.ingress_web_rules
        content {
            from_port         = ingress.value.port
            to_port           = ingress.value.port
            protocol          = "tcp"
            cidr_blocks       = ["0.0.0.0/0"]
        }
    } 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.project}-${terraform.workspace} SG instancesWeb"
  }
}

resource "aws_security_group" "database" {
  name        = "${var.project}-${terraform.workspace}-database-sg"
  description = "${var.project}-${terraform.workspace} SG database"
  vpc_id      = aws_vpc.vpc.id
    dynamic "ingress" {
        for_each = local.ingress_db_rules
        content {
            from_port         = ingress.value.port
            to_port           = ingress.value.port
            protocol          = "tcp"
            cidr_blocks       = ["0.0.0.0/0"]
        }
    } 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.project}-${terraform.workspace} SG database"
  }
}