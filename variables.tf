variable "global_tags" {
  description = "Tags for the website blog project"
  type        = map(string)
  default = {
    project = "website-blog",
  }
}

variable "bucket_name_blog" {
  type    = string
  default = "www.adrian-docs.com"
}

variable "bucket_name_apex" {
  type    = string
  default = "adrian-docs.com"
}

variable "cloudflare_zone_id" {
  type = string
}