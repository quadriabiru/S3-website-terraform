/*

Terraform file for setting up an S3 Bucket for webhosting

*/

resource "aws_s3_bucket" "example" {
  bucket = "<BUCKET NAME>"
}

resource "aws_s3_bucket_policy" "example_policy"{
    bucket = aws_s3_bucket.example.id 
    policy = jsonencode({
        "Version": "2017-10-17",
        "Statement": [
            {
                "Sid": "S3 Permissions", # Modify as you need
                "Effect": "Allow",
                "Principal": "*",
                "Action": [
                    "s3:PutObject"
                ],
                "Resource": "arn:aws:s3:::<BUCKET NAME>/*"
            }
        ]
    })
}

resource "aws_s3_object" "example_object" {
    for_each     = fileset("../path/to/webfiles", "**/*.{html,css,js,jpg,jpeg,png}")
    bucket = aws_s3_bucket.example.id
    key = each.value
    source = "../path/to/webfiles/${each.value}"
    content_type = lookup(local.content_types, regex("\\.[^.]+$", each.value), null)  # Meta tags the material using mapping in local.tf
    etag = filemd5("../path/to/webfiles/${each.value}")
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example" { # Makes content public
  bucket = aws_s3_bucket.example.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.example.id
  acl    = "private"
}

resource "aws_s3_bucket_website_configuration" "example"{
    bucket = aws_s3_bucket.example.id

    index_document {
      suffix = "index.html" # Assumes you have index.html in the top directory of your bucket
    }
}
