module "default_tags" {
  source = "git::https://github.com/gersontpc/aws_default_tags?ref=v1.0.2"
  additional_tags = {
    Custom = "BastionHost"
  }
  service_name     = var.service_name
  feature_name     = var.feature_name
  owner_email      = var.owner_email
  tech_owner_email = var.tech_owner_email
  environment      = var.environment
  squad            = var.squad
  finops           = var.finops
  repo_name        = var.repo_name
  pipeline         = var.pipeline
  tier             = var.tier
  sigla            = var.sigla
  sn               = var.sn
  account_id       = var.account_id
}

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

  tags = {
    Name = var.instance_name
  }
}
