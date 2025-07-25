provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "devops-rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "jenkins-vm-vnet" {
  name                = "jenkins-vm-vnet"
  location            = azurerm_resource_group.devops-rg.location
  resource_group_name = azurerm_resource_group.devops-rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "jenkins_subnet" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.devops-rg.name
  virtual_network_name = azurerm_virtual_network.jenkins-vm-vnet.name
  address_prefixes     = ["10.0.0.0/24"]
  private_endpoint_network_policies             = "Disabled"
  private_link_service_network_policies_enabled = true
  default_outbound_access_enabled               = true
}

resource "azurerm_network_interface" "jenkins_nic" {
  name                = "jenkins-vm593_z1"
  location            = azurerm_resource_group.devops-rg.location
  resource_group_name = azurerm_resource_group.devops-rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.jenkins_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jenkins_vm_ip.id
    primary                       = true
  }

  tags = {}
}

resource "azurerm_public_ip" "jenkins_vm_ip" {
  name                = "jenkins-vm-ip"
  location            = azurerm_resource_group.devops-rg.location
  resource_group_name = azurerm_resource_group.devops-rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = [var.vm_zone]

  idle_timeout_in_minutes = 4

  tags = {}
}

resource "azurerm_ssh_public_key" "jenkins_ssh_key" {
  name                = "jenkins-vm_key"
  location            = azurerm_resource_group.devops-rg.location
  resource_group_name = "DEVOPS-RG"

  public_key = var.public_ssh_key
}

resource "azurerm_linux_virtual_machine" "jenkins_vm" {
  name                = "jenkins-vm"
  reboot_setting      = "IfRequired"
  location            = azurerm_resource_group.devops-rg.location
  resource_group_name = azurerm_resource_group.devops-rg.name
  size                = var.vm_size
  zone                = var.vm_zone
  admin_username      = var.vm_admin_username
  network_interface_ids = [
    azurerm_network_interface.jenkins_nic.id
  ]

  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = var.public_ssh_key
  }

  disable_password_authentication = true

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    name                 = "jenkins-vm_OsDisk_1_237eab073e3c48b49cc8837255375e1f"
    disk_size_gb         = 30
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  boot_diagnostics {}

  patch_mode = "AutomaticByPlatform"

  additional_capabilities {
    hibernation_enabled = false
    ultra_ssd_enabled   = false
  }

  secure_boot_enabled = true
  vtpm_enabled        = true

  tags = {}
}

resource "azurerm_managed_disk" "jenkins_os_disk" {
  name                 = "jenkins-vm_OsDisk_1_237eab073e3c48b49cc8837255375e1f"
  location             = azurerm_resource_group.devops-rg.location
  resource_group_name  = "DEVOPS-RG"
  storage_account_type = "Premium_LRS"
  create_option        = "FromImage"
  disk_size_gb         = 30
  os_type              = "Linux"
  zone                 = var.vm_zone

  image_reference_id = "/Subscriptions/78a6d016-cf04-4a2b-a8a9-4e7e35b1be3f/Providers/Microsoft.Compute/Locations/FranceCentral/Publishers/canonical/ArtifactTypes/VMImage/Offers/0001-com-ubuntu-server-jammy/Skus/22_04-lts-gen2/Versions/22.04.202506120"
  hyper_v_generation  = "V2"

  network_access_policy = "AllowAll"

  tags = {}
  trusted_launch_enabled = true
}

resource "azurerm_network_security_group" "jenkins_nsg" {
  name                = "jenkins-vm-nsg"
  location            = azurerm_resource_group.devops-rg.location
  resource_group_name = azurerm_resource_group.devops-rg.name

  security_rule {
    name                       = "HTTPS"
    priority                   = 320
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 340
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-Jenkins-8080"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowJenkins-8080"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowPort3000"
    priority                   = 301
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-SonarQube"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
