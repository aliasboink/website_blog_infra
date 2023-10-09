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

data "cloudflare_ip_ranges" "cloudflare" {}

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
      values   = concat(data.cloudflare_ip_ranges.cloudflare.ipv4_cidr_blocks, data.cloudflare_ip_ranges.cloudflare.ipv6_cidr_blocks)
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