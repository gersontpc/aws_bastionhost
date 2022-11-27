data "template_file" "user_data" {
  template = file("${path.module}/templates/user-data.sh.tpl")

  vars = {
    instance_name = var.instance_name
  }
}

resource "aws_instance" "bastion_host" {
  ami                    = data.aws_ami.amazon2.id
  instance_type          = var.instance_type
  user_data              = base64encode(data.template_file.user_data.rendered)
  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]
  iam_instance_profile   = aws_iam_instance_profile.bastion.id
  key_name               = data.aws_key_pair.personal.key_name

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.volume_size
    delete_on_termination = true
    encrypted             = true
  }

  tags = merge(
    var.tags,
    {
      Name = "BastionHost"
    },
  )
}
