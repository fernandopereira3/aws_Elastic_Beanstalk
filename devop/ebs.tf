### CRIA O ELASTIC BEAN STALK
resource "aws_elastic_beanstalk_application" "app_beanstalk" {
  name        = var.nome
  description = "APP de BeanStalk"
}

#### CRIACAO DO AMBIENTE DO BEAN STALK 
resource "aws_elastic_beanstalk_environment" "ambiente_beanstalk" {
  name                = "${var.nome}-amb"
  application         = aws_elastic_beanstalk_application.app_beanstalk.name
  solution_stack_name = "64bit Amazon Linux 2023 v4.0.1 running Docker"

##### tipo de maquina vai ser usada 
 setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instancia
  }
## limite de maquinas 
 setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.max
  }

#### perfil de police usada 
setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.beanstalk_ec2_profile.name
  }

}
##### Versao da Aplicacao
resource "aws_elastic_beanstalk_application_version" "default" {
  name        = "${var.nome}-nome"
  application = var.nome
  description = "application version"
  bucket      = aws_s3_bucket.beanstalk_s3.id
  key         = aws_s3_bucket_object.docker.id
  depends_on = [ aws_elastic_beanstalk_environment.ambiente_beanstalk, aws_elastic_beanstalk_application.app_beanstalk, aws_s3_bucket_object.docker ]
}