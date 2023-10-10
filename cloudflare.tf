data "cloudflare_ip_ranges" "cloudflare" {}

resource "cloudflare_record" "blog" {
  zone_id         = var.cloudflare_zone_id
  name            = "www"
  value           = aws_s3_bucket_website_configuration.blog.website_endpoint
  type            = "CNAME"
  ttl             = 1
  allow_overwrite = false
  comment         = "This is a necessary value otherwise the Cloudflare TF Provider cries."
  proxied         = true
}

resource "cloudflare_record" "apex" {
  zone_id         = var.cloudflare_zone_id
  name            = "adrian-docs.com"
  value           = aws_s3_bucket_website_configuration.apex.website_endpoint
  type            = "CNAME"
  ttl             = 1
  allow_overwrite = false
  comment         = "This is a necessary value otherwise the Cloudflare TF Provider cries."
  proxied         = true
}
