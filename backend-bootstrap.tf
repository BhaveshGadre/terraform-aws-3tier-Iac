resource "aws_s3_bucket" "tf_state" {
  bucket = "project-2-tf-state-file"
  
   tags = {
    Name        = "Terraform State Bucket"
    }
  
}
