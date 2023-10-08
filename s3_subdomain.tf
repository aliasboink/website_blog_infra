# resource "random_string" "random" {
#   length  = 6
#   special = false
#   lower   = true
#   upper   = false
# }

resource "aws_s3_bucket" "blog" {
  bucket = var.bucket_name
  tags   = var.global_tags
}

resource "aws_s3_bucket_public_access_block" "blog_access" {
  bucket = aws_s3_bucket.blog.id

  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

# data "aws_iam_policy_document" "blog" {
#   statement {
#     actions   = ["s3:GetObject"]
#     resources = ["${aws_s3_bucket.blog.arn}/*"]

#     principals {
#       type        = "*"
#       identifiers = ["*"]
#     }
#   }
# }

data "aws_iam_policy_document" "blog" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.blog.arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values = [
        # "0.0.0.0/0",
        # "::/0"
        "173.245.48.0/20",
        "103.21.244.0/22",
        "103.22.200.0/22",
        "103.31.4.0/22",
        "141.101.64.0/18",
        "108.162.192.0/18",
        "190.93.240.0/20",
        "188.114.96.0/20",
        "197.234.240.0/22",
        "198.41.128.0/17",
        "162.158.0.0/15",
        "104.16.0.0/13",
        "104.24.0.0/14",
        "172.64.0.0/13",
        "131.0.72.0/22",
        "2400:cb00::/32",
        "2606:4700::/32",
        "2803:f800::/32",
        "2405:b500::/32",
        "2405:8100::/32",
        "2a06:98c0::/29",
        "2c0f:f248::/32"
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "blog" {
  bucket = aws_s3_bucket.blog.id
  policy = data.aws_iam_policy_document.blog.json
}

resource "aws_s3_bucket_website_configuration" "blog" {
  depends_on = [aws_s3_bucket_public_access_block.blog_access]
  bucket     = aws_s3_bucket.blog.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }

}