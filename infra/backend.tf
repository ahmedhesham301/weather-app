terraform {
  backend "s3" {
    bucket = "myrfstates"
    key = "state/terraform.tfstate"
    region = "eu-central-1"
    encrypt = true
    use_lockfile = true
  }
}