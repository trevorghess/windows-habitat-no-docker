variable "azure_region" {}

variable "image_name" {}

variable "windows_user" {
  default = "hab"
}

variable "windows_password" {
  default= "mypassword"
}

variable "azure_storage_account" {
  default = "workstationstorage"
}
variable "azure_resource_group" {
  default = "workstation"
}

variable "azure_sub_id" {
  default = "xxxxxxx-xxxx-xxxx-xxxxxxxxxx"
}

variable "azure_tenant_id" {
  default = "xxxxxxx-xxxx-xxxx-xxxxxxxxxx"
}

variable "tag_dept" {}

variable "tag_customer" {}

variable "tag_project" {}

variable "tag_application" {
  default = "workstation"
}

variable "tag_contact" {}

variable "contact_shortname" {}

variable "tag_ttl" {
  default = "8"
}
