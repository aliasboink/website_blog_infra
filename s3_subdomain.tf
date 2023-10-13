resource "aws_s3_bucket" "subdomain" {
  bucket = var.bucket_name_subdomain
  tags   = var.global_tags
}

resource "aws_s3_bucket_public_access_block" "subdomain_access" {
  bucket = aws_s3_bucket.subdomain.id

  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

data "aws_iam_policy_document" "subdomain" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.subdomain.arn}/*"]

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

resource "aws_s3_bucket_policy" "subdomain" {
  bucket = aws_s3_bucket.subdomain.id
  policy = data.aws_iam_policy_document.subdomain.json
}

resource "aws_s3_bucket_website_configuration" "subdomain" {
  depends_on = [aws_s3_bucket_public_access_block.subdomain_access]
  bucket     = aws_s3_bucket.subdomain.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }

}