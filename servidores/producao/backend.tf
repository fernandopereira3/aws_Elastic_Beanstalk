terraform {
  backend "s3" {
    bucket = "bucket-salvar"
    key    = "producao/terraform.tfstate"
    region = "us-west-2"
  }
}