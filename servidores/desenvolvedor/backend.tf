terraform {
  backend "s3" {
    bucket = "bucket-salvar"
    key    = "desenvolvedor/terraform.tfstate"
    region = "us-west-2"
  }
}