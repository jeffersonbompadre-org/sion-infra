# Outputs
#
# Este arquivo contém os outputs que podem ser usados por outros módulos
# ou para visualização após o apply.

# Outputs do Secrets Manager
output "identity_default_secret_arn" {
  description = "ARN do secret de configurações do banco de dados"
  value       = aws_secretsmanager_secret.identity_default.arn
}

output "identity_default_secret_name" {
  description = "Nome do secret de configurações do banco de dados"
  value       = aws_secretsmanager_secret.identity_default.name
}

output "identity_default_jwt_secret_arn" {
  description = "ARN do secret de configurações JWT"
  value       = aws_secretsmanager_secret.identity_default_jwt.arn
}

output "identity_default_jwt_secret_name" {
  description = "Nome do secret de configurações JWT"
  value       = aws_secretsmanager_secret.identity_default_jwt.name
}
