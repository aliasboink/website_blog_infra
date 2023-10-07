# provider "aws" {
#    alias = "acm_provider"
#    region = "us-east-1"
# }

# resource "aws_acm_certificate" "blog" {
#    provider          = aws.acm_provider
#    domain_name       = var.domain
#    validation_method = "DNS"
 
#    tags = var.global_tags
 
#    lifecycle {
#        create_before_destroy = true
#    }
# }