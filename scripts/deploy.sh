#!/bin/bash

# Script de deploy para Sion Infra no LocalStack

set -e

echo "======================================"
echo "Sion Infra - Deploy para LocalStack"
echo "======================================"
echo ""

# Verifica se está no diretório correto
if [ ! -d "terraform" ]; then
    echo "Erro: Diretório 'terraform' não encontrado."
    echo "Execute este script na raiz do repo sion-infra."
    exit 1
fi

# Verifica se o LocalStack está rodando
echo "Verificando se LocalStack está rodando..."
if ! curl -s http://localhost:4566 > /dev/null; then
    echo "Erro: LocalStack não está rodando em http://localhost:4566"
    echo "Inicie o LocalStack com:"
    echo "  cd docker/sion-infra-localstack"
    echo "  docker-compose up -d"
    exit 1
fi

echo "LocalStack está rodando. ✓"
echo ""

# Navega para o diretório terraform
cd terraform

# Inicializa o Terraform
echo "Inicializando Terraform..."
terraform init

# Plano
echo ""
echo "Gerando plano de execução..."
terraform plan -out=tfplan

# Apply
echo ""
echo "Aplicando recursos..."
terraform apply -auto-approve tfplan

# Limpa o arquivo de plano
rm -f tfplan

echo ""
echo "======================================"
echo "Deploy concluído com sucesso! ✓"
echo "======================================"
