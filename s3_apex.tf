resource "aws_s3_bucket" "blog_apex" {
   bucket = "${var.bucket_name_apex}"
   tags   = var.global_tags
}

resource "aws_s3_bucket_website_configuration" "blog_apex" {
  bucket = aws_s3_bucket.blog_apex.id

  redirect_all_requests_to {
    host_name = "www.adrian-docs.com.s3-website.eu-central-1.amazonaws.com"
  }
}