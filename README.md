# Sion Infra

Repositório de infraestrutura compartilhada para os serviços Sion. Gerencia recursos AWS compartilhados via Terraform.

## Estrutura

```
terraform/
  main.tf         - Definição dos recursos (Secrets Manager)
  providers.tf    - Configuração do provider AWS (aponta para LocalStack)
  versions.tf     - Versões do Terraform e providers
.github/workflows/
  ci-cd.yml       - Workflow de CI/CD para deploy no LocalStack
```

## Pré-requisitos

Antes de usar este repo, certifique-se de que:

1. **LocalStack está rodando**:
   ```bash
   cd docker/sion-infra-localstack
   docker-compose up -d
   ```

2. **GitHub Runner está configurado**:
   ```bash
   cd docker/sion-github-runner
   cp .env.example .env
   # Edite .env com GITHUB_TOKEN e GITHUB_OWNER
   docker-compose up -d
   ```

## Deploy

O deploy é automático via GitHub Actions quando há push no branch `main`. Você também pode executar manualmente via `workflow_dispatch` na interface do GitHub.

## Testes Locais

Para testar localmente sem o GitHub Actions:

```bash
cd terraform
terraform init
terraform plan
terraform apply
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
