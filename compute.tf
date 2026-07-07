#LAUNCH TEMPLATE#

resource "aws_launch_template" "webapp_lt" {
  name_prefix   = "webapp-launch-template"
  image_id      = "ami-0b6d9d3d33ba97d99"
  instance_type = "t3.small"

  key_name = "project-key"

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
  max_size            = 4
  min_size            = 2
  desired_capacity    = 2
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