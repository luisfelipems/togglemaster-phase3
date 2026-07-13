# Criar o bucket S3 (execute apenas uma vez!)
aws s3api create-bucket --bucket togglemaster-terraform-state-lfmsfiap --region sa-east-1 --create-bucket-configuration LocationConstraint=sa-east-1

# Habilitar versionamento para permitir recuperar versões anteriores do state
aws s3api put-bucket-versioning --bucket togglemaster-terraform-state-lfmsfiap --versioning-configuration Status=Enabled