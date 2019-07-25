resource "aws_instance" "default" {
	ami = "ami-0c30afcb7ab02233d"
	instance_type = "t2.micro"
	subnet_id = "${aws_subnet.default.id}"
	vpc_security_group_ids = ["${aws_security_group.default.id}"]
	private_ip = "10.0.0.21"
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
			"sudo docker run -d -p 80:80 --name vmone_ui_1 hmsbennett/pool_ui:latest"
		]
	}
}

resource "aws_instance" "api" {
    ami = "ami-0c30afcb7ab02233d"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.default.id}"
    vpc_security_group_ids = ["${aws_security_group.default.id}"]
	private_ip = "10.0.0.22"
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
			"sudo docker run -d -e MONGO_HOST=${aws_instance.db.private_ip} --name vmone_api_1 hmsbennett/pool_api:latest"
        ]
    }
}
resource "aws_instance" "db" {
    ami = "ami-0c30afcb7ab02233d"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.default.id}"
    vpc_security_group_ids = ["${aws_security_group.default.id}"]
	private_ip = "10.0.0.23"
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
			"sudo docker run -d -p 27017:27017 --name vmone_mongo_1 mongo:latest"
        ]
    }
}
