#LAUNCH TEMPLATE#

resource "aws_launch_template" "webapp_lt" {
  name_prefix   = "webapp-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type

  key_name = var.key_name

  network_interfaces {
    security_groups = [aws_security_group.webapp_sg.id]
  }

  user_data = base64encode(<<-EOF
  #!/bin/bash
  apt update -y
  apt install apache2 -y
  systemctl enable apache2
  systemctl start apache2

  echo "<h1>Terraform 3-Tier Infrastructure</h1>" > /var/www/html/index.html
  echo "<h2>Hostname: $(hostname)</h2>" >> /var/www/html/index.html
  EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "webapp-instance"
    }
  }
}

#AUTP SCALING GROUP#

resource "aws_autoscaling_group" "webapp_asg" {
  name                = "webapp-asg"
  max_size            = var.asg_max_size
  desired_capacity    = var.asg_desired_capacity
  min_size            = var.asg_min_size
  vpc_zone_identifier = [aws_subnet.pvt_a.id, aws_subnet.pvt_b.id]
  launch_template {
    id      = aws_launch_template.webapp_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.webapp_tg.arn]

  health_check_type = "ELB"

  tag {
    key                 = "Name"
    value               = "webapp-instance"
    propagate_at_launch = true
  }
}