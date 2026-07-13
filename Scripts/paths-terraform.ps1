$base = "C:\Users\Felipe PC\Documents\Pós\Tech Challenge 2\Terraform"
$modulos = @("networking", "eks", "rds", "elasticache", "dynamodb", "sqs", "ecr")

New-Item -ItemType Directory -Force -Path $base
foreach ($m  in $modulos) {
	New-Item -ItemType Directory -Force -Path "$base\modules\$m"
}

Write-Host "Estrutura de pastas criada!" -ForegroundColor Green
