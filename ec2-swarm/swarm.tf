# Launch a CentOS Atomic Host instance to serve as Swarm manager
resource "aws_instance" "manager" {
    ami                     = "${data.aws_ami.swarm_ami.id}"
    instance_type           = "${var.mgr_flavor}"
    key_name                = "${var.keypair}"
    vpc_security_group_ids  = ["${aws_security_group.swarm_sg.id}"]
    subnet_id               = "${aws_subnet.ec2_swarm_public.id}"
    depends_on              = ["aws_internet_gateway.ec2_swarm_gw"]
    tags {
        tool                = "terraform"
        demo                = "ec2-swarm"
        area                = "instances"
        role                = "manager"
    }
}

# Launch 3 CentOS Atomic Host instances to serve as Swarm worker nodes
resource "aws_instance" "worker" {
    ami                     = "${data.aws_ami.swarm_ami.id}"
    count                   = 3
    instance_type           = "${var.wkr_flavor}"
    key_name                = "${var.keypair}"
    vpc_security_group_ids  = ["${aws_security_group.swarm_sg.id}"]
    subnet_id               = "${aws_subnet.ec2_swarm_public.id}"
    depends_on              = ["aws_internet_gateway.ec2_swarm_gw"]
    tags {
        tool                = "terraform"
        demo                = "ec2-swarm"
        area                = "instances"
        role                = "worker"
    }
}
