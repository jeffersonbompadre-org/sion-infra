# Secrets Manager - Identity API

# Secret com configurações de banco de dados
resource "aws_secretsmanager_secret" "identity_default" {
  name = "sion-identity-default"
}

resource "aws_secretsmanager_secret_version" "identity_default" {
  secret_id = aws_secretsmanager_secret.identity_default.id
  secret_string = jsonencode({
    Host     = "<host-do-mysql>"
    Database = "<nome-do-banco>"
    User     = "<usuario>"
    Password = "<senha>"
    Port     = 3306
  })
}

# Secret com configurações JWT
resource "aws_secretsmanager_secret" "identity_default_jwt" {
  name = "sion-identity-default-jwt"
}

resource "aws_secretsmanager_secret_version" "identity_default_jwt" {
  secret_id = aws_secretsmanager_secret.identity_default_jwt.id
  secret_string = jsonencode({
    SigningKey = "<chave-aleatoria-com-pelo-menos-32-bytes>"
  })
}

# Outputs para referência em outros módulos
output "identity_default_secret_arn" {
  description = "ARN do secret de configurações do banco"
  value       = aws_secretsmanager_secret.identity_default.arn
}

output "identity_default_jwt_secret_arn" {
  description = "ARN do secret de configurações JWT"
  value       = aws_secretsmanager_secret.identity_default_jwt.arn
}
