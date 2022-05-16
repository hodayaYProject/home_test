# home test

require:
 aws account
 docker install
 terraform install

 clone the project
 build EC2 instance on AWS 
 generate ssh key
 compy the pub file to public_key - line 10 
 

 terrafrom init
 terraform plan
 terraform apply

 set the inbound rule for security group id to ssh port 20 to give access via ssh
insert to ec2 server via the private key:
ssh -i ~/.ssh/id_rsa ubuntu@PUBLIC_IPV4 
install docker inside

