resource "aws_s3_bucket" "blog" {
   bucket = "${var.bucket_name}"
   tags   = var.global_tags
}

resource "aws_s3_bucket_public_access_block" "bucket_access" {
  bucket = aws_s3_bucket.blog.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

data "aws_iam_policy_document" "blog" {
   statement {
       actions   = ["s3:GetObject"]
       resources = ["${aws_s3_bucket.blog.arn}/*"]
 
       principals {
        type        = "*"
        identifiers = ["*"]
       }
    }
   }
 
resource "aws_s3_bucket_policy" "blog" {
   bucket = aws_s3_bucket.blog.id
   policy = data.aws_iam_policy_document.blog.json
}
 
resource "aws_s3_bucket_website_configuration" "blog" {
    depends_on = [aws_s3_bucket_public_access_block.bucket_access]
    bucket = aws_s3_bucket.blog.bucket
  
    index_document {
        suffix = "index.html"
    }
  
    error_document {
        key = "404.html"
    }
 
}