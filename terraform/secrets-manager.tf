# AWS Secrets Manager - Identity API
#
# Este arquivo gerencia os secrets do Secrets Manager para a API de identidade.

# Secret com configurações de banco de dados
resource "aws_secretsmanager_secret" "identity_default" {
  name = "sion-identity-default"

  tags = {
    Service = "sion-identity-api"
    Environment = "local"
  }
}

resource "aws_secretsmanager_secret_version" "identity_default" {
  secret_id = aws_secretsmanager_secret.identity_default.id
  secret_string = jsonencode({
    Host     = "localhost"
    Database = "devdb"
    User     = "devuser"
    Password = "devpassword"
    Port     = 3306
  })
}

# Secret com configurações JWT
resource "aws_secretsmanager_secret" "identity_default_jwt" {
  name = "sion-identity-default-jwt"

  tags = {
    Service = "sion-identity-api"
    Environment = "local"
  }
}

resource "aws_secretsmanager_secret_version" "identity_default_jwt" {
  secret_id = aws_secretsmanager_secret.identity_default_jwt.id
  secret_string = jsonencode({
    SigningKey = "GkgewBCoe2wpyn+uDo06gEpBqBGvw80OQyGRPwB5ZUU="
  })
}
