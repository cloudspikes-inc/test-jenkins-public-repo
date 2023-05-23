terraform {
  backend "s3" {
    bucket         = "test-cloud-devops-terraform-state-backend"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform_state_db"
    encrypt        = true
  }
}