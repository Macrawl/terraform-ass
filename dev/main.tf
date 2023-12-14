# create vpc module
module "vpc" {
  source                       = "./modules/vpc"
  region                       = var.region
  
}

# create security groups module
module "security-groups" {
  source                       = "./modules/security-groups"
  project_name                 = module.vpc.project_name
  vpc_id                       = module.vpc.vpc_id
}

# create ec2 module
module "instances" {
  source                       = "./modules/instances"
 
}