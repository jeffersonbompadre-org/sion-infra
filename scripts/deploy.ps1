# Script de deploy para Sion Infra no LocalStack (PowerShell)

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "Sion Infra - Deploy para LocalStack" -ForegroundColor Cyan
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

# Inicializa o Terraform
Write-Host "Inicializando Terraform..."
terraform init

# Plano
Write-Host ""
Write-Host "Gerando plano de execução..."
terraform plan -out=tfplan

# Apply
Write-Host ""
Write-Host "Aplicando recursos..."
terraform apply -auto-approve tfplan

# Limpa o arquivo de plano
Remove-Item -Path tfplan -ErrorAction SilentlyContinue

# Volta para o diretório original
Set-Location ..

Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "Deploy concluído com sucesso! ✓" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Cyan
