# Verificar todas as ferramentas de uma vez
Write-Host "=== Verificando ferramentas ===" -ForegroundColor Cyan

$tools = @(
	@{ Name = "AWS CLI"; Cmd = "aws --version" },
	@{ Name = "Terraform"; Cmd = "terraform --version" },
	@{ Name = "kubectl"; Cmd = "kubectl version --client" },
	@{ Name = "Helm"; Cmd = "helm version --short" },
	@{ Name = "Docker"; Cmd = "docker --version" },
	@{ Name = "Git"; Cmd = "git --version" },
	@{ Name = "ArgoCD CLI"; Cmd = "argocd version --client" }
)

foreach ($tool in $tools) {
	Write-Host "`n[$($tool.Name)]" -ForegroundColor Yellow
	Invoke-Expression $tool.Cmd
}

Write-Host "`n=== Tudo verificado! ===" -ForegroundColor Green