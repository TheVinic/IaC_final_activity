resource "aws_instance" "instanceFront" {
  count = var.instance_frontend
  ami           = data.aws_ami.ubuntu.image_id
  instance_type = "t3.small"
  key_name      = var.key_name
  user_data     = "${ file("${path.module}/installHttpd.sh") }"
  subnet_id              = aws_subnet.public[count.index % var.subnet_public_quantity].id
  vpc_security_group_ids = [aws_security_group.instancesWeb.id]
  root_block_device {
    volume_type = "gp3"
    volume_size = 20 
  }
  tags = {
    Name = "${var.project}-{terraform.workspace} ${count.index}"
  }
}

resource "aws_instance" "instaceBack" {
  count = var.instance_backend
  ami           = data.aws_ami.amazon.image_id
  instance_type = "t3.small"
  key_name      = var.key_name
  user_data     = "${ file("${path.module}/installNginxMysql.sh") }"
  subnet_id              = aws_subnet.private[count.index % var.subnet_private_amount].id
  vpc_security_group_ids = [aws_security_group.instancesWeb.id]
  root_block_device {
    volume_type = "gp3"
    volume_size = local.storage_instace[terraform.workspace] 
  }
  tags = {
    Name = "${var.project}-{terraform.workspace} ${count.index}"
  }
}