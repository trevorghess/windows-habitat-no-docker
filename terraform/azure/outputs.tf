output "Windows Server IP Address" {
  value = ["${azurerm_public_ip.pip.*.ip_address}"]
}