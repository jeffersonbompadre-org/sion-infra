# Sion Infra

Repositório de infraestrutura compartilhada para os serviços Sion. Gerencia recursos AWS compartilhados via Terraform.

## Estrutura

```
terraform/
  main.tf         - Definição dos recursos (Secrets Manager)
  providers.tf    - Configuração do provider AWS (aponta para LocalStack)
  versions.tf     - Versões do Terraform e providers
scripts/
  deploy.sh       - Script de deploy local
  destroy.sh      - Script de destruição de recursos
```

## Pré-requisitos

Antes de usar este repo, certifique-se de que:

1. **LocalStack está rodando**:
   ```bash
   cd docker/sion-infra-localstack
   docker-compose up -d
   ```

2. **Terraform está instalado**:
   - Download: https://developer.hashicorp.com/terraform/downloads
   - Verificar instalação: `terraform --version`

## Deploy Local

Para fazer o deploy dos recursos no LocalStack:

```bash
# Na raiz do repo sion-infra
./scripts/deploy.sh
```

O script irá:
1. Navegar para o diretório terraform
2. Executar `terraform init`
3. Executar `terraform plan`
4. Executar `terraform apply` com auto-approve

## Destroy

Para remover todos os recursos criados:

```bash
./scripts/destroy.sh
```

## Testes Manuais

Para executar comandos manualmente:

```bash
cd terraform
terraform init
terraform plan
terraform apply
terraform destroy
```

## Recursos Gerenciados

Atualmente este repo gerencia:

- **AWS Secrets Manager**:
  - `sion-identity-default`: Configurações de banco de dados (Host, Database, User, Password, Port)
  - `sion-identity-default-jwt`: Configurações JWT (SigningKey)

## Integração com Outros Serviços

Outros serviços (ex: `sion-identity-api`) podem referenciar estes secrets via:
- Terraform remote state (para deploy automatizado)
- AWS SDK no código da aplicação (para leitura dos secrets em runtime)

## Próximos Passos

Conforme necessário, este repo pode ser expandido para incluir:
- VPC
- ECR repositories
- IAM base roles
- Outros recursos compartilhados
- CI/CD automatizado (GitHub Actions, GitLab CI, etc)
