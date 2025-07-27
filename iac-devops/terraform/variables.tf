variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = "78a6d016-cf04-4a2b-a8a9-4e7e35b1be3f"
}

variable "resource_group_name" {
  description = "Nom du groupe de ressources Azure"
  type        = string
  default     = "devops-rg"
}

variable "location" {
  description = "Région Azure"
  type        = string
  default     = "francecentral"
}

variable "vm_admin_username" {
  description = "Nom de l'utilisateur admin pour la VM"
  type        = string
  default     = "azureuser"
}

variable "vm_size" {
  description = "Taille de la VM"
  type        = string
  default     = "Standard_B1ms"
}

variable "vm_zone" {
  description = "Zone pour la VM"
  type        = string
  default     = "1"
}

variable "public_ssh_key" {
  description = "Clé SSH publique pour la VM"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQChWdOXPducRxpAkvr2ZYgh+drZCetRK5NjRTwVDyJVb9GmXXAyj15vwgXGPtxc1tT0TITrdXq8TaDA11+cnkPiCEMcCwVzxBuq+gINwddL5kkZtpfeBodulGojFvBAHiPuZTCKhJ0wgvzKEzLuPrEKoDg3hIudvpYmk+Jn5BBomW8kc5qmRx6X7jwKjPxi2dekwQuvGRxJvc+lZgeqhTXnIKrfeIUIETxxTU2VPSyDr8SaHgwkDHL0epKqc6GtbzYgm5ic6UQVhs68T18q19lHf5SeRNasRWweZFB4kjqCd8v+vKUBe9DnyR8ajYGLwlWDVQ/j0fd7w3J82owKPEcOj3xPWpl5prF42J9d4WO3EIOXrnYT/4YYsHAa1opw1Gg9N7puwa0q/k1lPzOtuuWXaUBsKzEASR6tiA/mV8XfjfOa+AUH8DW6GT2Kycrpw5DbyV2mJ5Tjb6tYQLni0Sg6I3tcr0cPPHPTKH77OrOoJu8WXLZoB69E+wTCZV+X1Y0= generated-by-azure"
}
