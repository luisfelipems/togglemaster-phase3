terraform {
	backend "s3" {
		bucket = "togglemaster-terraform-state-felipe"
		key = "fase3/terraform.tfstate"
		region = "sa-east-1"
		use_lockfile = true
	}
}