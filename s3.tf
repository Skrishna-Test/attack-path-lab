# S3 Bucket Create

# Generate a random string for the S3 bucket name
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

# Create an S3 bucket with a random name
resource "aws_s3_bucket" "pc-national-bank-bucket" {
  bucket = "pc-national-bank-bucket-${random_string.bucket_suffix.result}"
  tags = {
    yor_name  = "pc-national-bank-bucket"
    yor_trace = "f1111537-0ac6-44dd-bfb3-5edd70136226"
  }
}

resource "aws_s3_object" "pc-national-bank-bucket-object" {
  for_each = fileset("${path.module}/s3_files", "*")
  bucket   = aws_s3_bucket.pc-national-bank-bucket.bucket
  key      = each.value
  source   = "${path.module}/s3_files/${each.value}"
  tags = {
    yor_name  = "pc-national-bank-bucket-object"
    yor_trace = "250e8833-2351-4e84-a53a-b00de37d84f9"
  }
}