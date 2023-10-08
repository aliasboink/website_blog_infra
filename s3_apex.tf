# resource "aws_s3_bucket" "blog_apex" {
#   bucket = var.bucket_name_apex
#   tags   = var.global_tags
# }

# resource "aws_s3_bucket_website_configuration" "blog_apex" {
#   depends_on = [aws_s3_bucket_public_access_block.blog_access_apex]
#   bucket     = aws_s3_bucket.blog_apex.id

#   redirect_all_requests_to {
#     host_name = "www.adrian-docs.com"
#   }
# }

# resource "aws_s3_bucket_public_access_block" "blog_access_apex" {
#   bucket = aws_s3_bucket.blog_apex.id

#   block_public_acls       = true
#   block_public_policy     = false
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }


# data "aws_iam_policy_document" "blog_apex" {
#   statement {
#     actions   = ["s3:GetObject"]
#     resources = ["${aws_s3_bucket.blog_apex.arn}/*"]

#     principals {
#       type        = "*"
#       identifiers = ["*"]
#     }

#     condition {
#       test     = "IpAddress"
#       variable = "aws:SourceIp"
#       values = [
#         "173.245.48.0/20",
#         "103.21.244.0/22",
#         "103.22.200.0/22",
#         "103.31.4.0/22",
#         "141.101.64.0/18",
#         "108.162.192.0/18",
#         "190.93.240.0/20",
#         "188.114.96.0/20",
#         "197.234.240.0/22",
#         "198.41.128.0/17",
#         "162.158.0.0/15",
#         "104.16.0.0/13",
#         "104.24.0.0/14",
#         "172.64.0.0/13",
#         "131.0.72.0/22",
#         "2400:cb00::/32",
#         "2606:4700::/32",
#         "2803:f800::/32",
#         "2405:b500::/32",
#         "2405:8100::/32",
#         "2a06:98c0::/29",
#         "2c0f:f248::/32"
#       ]
#     }
#   }
# }

# resource "aws_s3_bucket_policy" "blog_apex" {
#   bucket = aws_s3_bucket.blog_apex.id
#   policy = data.aws_iam_policy_document.blog_apex.json
# }