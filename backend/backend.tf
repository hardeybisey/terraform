terraform {
    backend "gcs" {
        bucket  = "my_terraform_state_bucket"
        prefix  = "terraform/state"
    }
}