provider "aws" {
    region = "us-east-1"

}
resource "aws_s3_bucket" "temps3" {

    bucket = "aws-s3-new-bucket-2024-tumkur" 

    acl = "private"   

}
