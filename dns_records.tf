resource "cloudflare_record" "blog" {
  zone_id         = var.cloudflare_zone_id
  name            = "adrian-docs.com"
  value           = "b78td1-website-blog-shush.s3-website.eu-central-1.amazonaws.com"
  type            = "CNAME"
  ttl             = 1
  allow_overwrite = false
  comment         = "This is a necessary value otherwise the Cloudflare TF Provider cries."
  proxied         = true
}

resource "cloudflare_record" "blog_apex" {
  zone_id         = var.cloudflare_zone_id
  name            = "www"
  value           = "b78td1-website-blog-shush.s3-website.eu-central-1.amazonaws.com"
  type            = "CNAME"
  ttl             = 1
  allow_overwrite = false
  comment         = "This is a necessary value otherwise the Cloudflare TF Provider cries."
  proxied         = true
}
