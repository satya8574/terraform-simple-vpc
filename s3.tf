
resource "aws_s3_bucket" "veloce_bucket" {
  bucket = var.s3_bucket_name
  #region = "us-east-1"
  tags = {
    Name        = var.s3_bucket_name
    Creator     = var.creator_name
    Environment = var.environment_name
    ManagedBy   = var.managedby
  }
}
resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.veloce_bucket.id
  #  region         = "us-east-1"
  acl = "private"
}
resource "aws_dynamodb_table" "forstate" {
  name = "for_sate_lock"
  #region         = "us-east-1"
  hash_key       = "LockID"
  read_capacity  = "4"
  write_capacity = "4"
  tags = {
    Name = "satateLock"
    # depends_on = [aws_s3_bucket.bucket]
  }
  attribute {
    name = "LockID"
    type = "S"
  }

}

# terraform {
#   backend "s3" {
#     bucket         = "satya87456"
#     key            = "terraform.tfstate"
#     dynamodb_table = "for_sate_lock"
#     region = "us-east-1"
#     encrypt        = true
# #    depends_on = aws_dynamodb_table.forstate.id
#   }
# }



