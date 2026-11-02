# Script de destruição para Sion Infra no LocalStack (PowerShell)

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "Sion Infra - Destroy (LocalStack)" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Verifica se está no diretório correto
if (-not (Test-Path "terraform")) {
    Write-Host "Erro: Diretório 'terraform' não encontrado." -ForegroundColor Red
    Write-Host "Execute este script na raiz do repo sion-infra."
    exit 1
}

# Verifica se o LocalStack está rodando
Write-Host "Verificando se LocalStack está rodando..."
try {
    $response = Invoke-WebRequest -Uri "http://localhost:4566" -UseBasicParsing -TimeoutSec 5
    Write-Host "LocalStack está rodando. ✓" -ForegroundColor Green
} catch {
    Write-Host "Erro: LocalStack não está rodando em http://localhost:4566" -ForegroundColor Red
    Write-Host "Inicie o LocalStack com:"
    Write-Host "  cd docker/sion-infra-localstack"
    Write-Host "  docker-compose up -d"
    exit 1
}

Write-Host ""

# Navega para o diretório terraform
Set-Location terraform

# Verifica se o Terraform já foi inicializado
if (-not (Test-Path ".terraform")) {
    Write-Host "Terraform não foi inicializado. Executando init..."
    terraform init
}

# Destroy
Write-Host "Removendo todos os recursos..."
terraform destroy -auto-approve

# Volta para o diretório original
Set-Location ..

Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "Destruição concluída com sucesso! ✓" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Cyan
