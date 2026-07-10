resource "aws_s3_bucket" "tf_state" {
  bucket = "project-2-tf-state-file"
  
   tags = {
    Name        = "Terraform State Bucket"
    }
  
}

resource "aws_dynamodb_table" "tf_lock" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}