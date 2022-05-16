provider "aws" {
  region = "eu-central-1"
  access_key = "AKIA25ZPUMYN2A4GFK3H"
  secret_key = "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"
}

resource "aws_key_pair" "terraform-ssh-key"{
    key_name = "terraform-ssh-key"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDM3+VTefbrUdiuvtiQNMlUPh8UbA29bSIBCS//Kj5NSFONxZmDrW6m9s7yffA9EgsI2PeYMU4howdAd43I24VU3HRfgn8jLG4WSMlgAxQ5Ffd6KAunceQrWsCtLDR4d7XQEH/F4h43wyigVUMz7RaT0CLj0+cD11mnGjByRuGnb96rTYg835NHJsVam2jVkpHXx2GJVqBIfr1OH4g8CdbeFoxKe3psLuBQKqwD2UAJJZlsl0y8f2gFnMKLRfwaUZ7/dVLpd8LlQ49t5idWN7TeOEGUly6Es7+LDMla4Ejg6Q7tt6wcKzYPOAFDCEuz8mJvWnXrE5hnUm9A0mVJBTI6z/pwBhakBbKeoS83BZ5/6llyJ8jHbXVFOWQHGoKQvh7PNFb0HThKYQzfLgo1fnJFX2mi7HfNUl14p1d342nZHHdowOXT0gwnsZ1gOKmzGZSS7xrGPHPNRy3BkjmcMOFBCEJ8xIssiqz/g+ZJIP+0ttQp4uMqycfZT3AyFPI2YUU= hodiy@DESKTOP-EUO0MDS"
}

resource "aws_instance" "example" {
  ami           = "ami-0cc0a36f626a4fdf5"
  instance_type = "t2.micro"
  key_name = "terraform-ssh-key"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              yes | sudo apt install nginx
              sudo install docker.io
              EOF
  
  tags = {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-home-test-instance"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Add Output
output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP of the web server"
}

