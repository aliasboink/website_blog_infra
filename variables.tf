variable "global_tags" {
  description = "Tags for the website blog project"
  type        = map(string)
  default = {
    project = "website-blog",
  }
}

variable "bucket_name" {
  type    = string
  default = "www.adrian-docs.com"
}

variable "cloudflare_zone_id" {
  type = string
}