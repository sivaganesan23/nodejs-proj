resource "aws_security_group" "instance-sg" {
  name        = "Nodejs-Proj-Instance-SG"
  description = "Nodejs-Proj-Instance-SG"
  vpc_id      = "${var.vpcid}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "server" {
    count                   = 1
    ami                     = "${var.ami}"
    instance_type           = "t2.micro"
    key_name                = "${var.keyname}"
    subnet_id               = "${element(var.public_subnets, count.index)}"
    vpc_security_group_ids  = ["${aws_security_group.instance-sg.id}"]
    tags                    = {
        Name        = "${var.proj}-node-${element(var.az-single-char, count.index)}"
        Application = "${var.application}"
    }
}

resource "null_resource" "appsetup" {
    count = 1
    provisioner "remote-exec" {
        inline = [
        "sudo yum install epel-release -y",
        "sudo yum install ansible git -y",
        "ansible-pull -U https://github.com/sivaganesan23/nodejs-proj.git ansible_pull/webapp.yml",
        "cd /home/centos/nodejs-app/",
        "node app.js",
          
          ]

        connection {
            type        = "ssh"
            user        = "centos"
            private_key = "${file("/home/centos/devops.pem")}"
            host        = "${element(aws_instance.server.*.private_ip, count.index)}"
        }
  }
}

resource "local_file" "ipaddress_of_ec2" {
    content     = "${element(aws_instance.server.*.private_ip, 0)}"
    filename = "/tmp/hosts"
}

resource "local_file" "public_address_of_ec2" {
    content     = "${element(aws_instance.server.*.public_ip, 0)}"
    filename = "/tmp/pubip"
}
