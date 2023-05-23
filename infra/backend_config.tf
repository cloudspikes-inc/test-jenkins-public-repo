terraform {
  backend "s3" {
    bucket         = "test-tf-state-backend-837c5yw"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "tf_state_db"
    encrypt        = true
  }
}
