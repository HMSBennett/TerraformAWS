resource "aws_subnet" "default" {
	vpc_id = "${aws_vpc.default.id}"
	cidr_block = "10.0.0.0/24"
}

resource "aws_subnet" "api" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "10.0.10.0/24"
}

resource "aws_subnet" "db" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "10.0.20.0/24"
}
