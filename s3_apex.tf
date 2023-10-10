resource "aws_s3_bucket" "apex" {
  bucket = var.bucket_name_apex
  tags   = var.global_tags
}

resource "aws_s3_bucket_public_access_block" "apex_access" {
  bucket = aws_s3_bucket.apex.id

  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

data "aws_iam_policy_document" "apex" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.apex.arn}/*"]

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

resource "aws_s3_bucket_policy" "apex" {
  bucket = aws_s3_bucket.apex.id
  policy = data.aws_iam_policy_document.apex.json
}

resource "aws_s3_bucket_website_configuration" "apex" {
  depends_on = [aws_s3_bucket_public_access_block.apex_access]
  bucket     = aws_s3_bucket.apex.bucket

  redirect_all_requests_to {
    host_name = var.bucket_name_blog
  }

}