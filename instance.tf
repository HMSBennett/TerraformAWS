resource "aws_instance" "default" {
	ami = "ami-0c30afcb7ab02233d"
	instance_type = "t2.micro"
	subnet_id = "${aws_subnet.default.id}"
	vpc_security_group_ids = ["${aws_security_group.default.id}"]
	associate_public_ip_address = true
	key_name = "default-key-pair"
	provisioner "remote-exec" {
		connection {
			type = "ssh"
			host = "${self.public_ip}"
			user = "ubuntu"
			private_key = "${file("~/.ssh/id_rsa")}"
		}
		inline = [
			"sudo apt-get install git",
			"git clone http://github.com/HMSBennett/DockerInstall",
			"cd DockerInstall",
			"./install.sh",
			"./docCompInstall.sh",
			"cd ..",
			"git clone https://github.com/HMSBennett/DockerMEAN",
			"cd DockerMEAN",
			"cd OneVM",
			"sudo systemctl enable docker",
			"sudo systemctl start docker",
			"sudo docker-compose up -d"
		]
	}
}
