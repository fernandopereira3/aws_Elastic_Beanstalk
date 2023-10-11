resource "aws_s3_bucket" "beanstalk_s3" {
  bucket = "${var.nome}-s3"
}

#### seguranca do bucket ACL 
resource "aws_s3_bucket_ownership_controls" "controle_s3" {
  bucket = aws_s3_bucket.beanstalk_s3.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_public_access_block" "block_pub" {
  bucket = aws_s3_bucket.beanstalk_s3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws_s3_bucket_acl" "s3_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.controle_s3,
    aws_s3_bucket_public_access_block.block_pub,
  ]
  bucket = aws_s3_bucket.beanstalk_s3.id
  acl    = "public-read"
}

#### upload de arquivos
resource "aws_s3_bucket_object" "docker" {
  bucket = "${var.nome}-s3"
  key    = "${var.nome}.zip"
  source = "${var.nome}.zip"
  depends_on = [ aws_s3_bucket.beanstalk_s3 ]
  etag = filemd5("${var.nome}.zip")
}