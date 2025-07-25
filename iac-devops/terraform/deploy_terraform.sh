#!/bin/bash

set -e  # stop on error

echo "🚀 Starting Terraform deployment..."

# Vérifier si 'az login' a été fait
if ! az account show > /dev/null 2>&1; then
  echo "❌ Azure CLI n'est pas connecté. Exécutez 'az login' manuellement sur la VM avant de continuer."
  exit 1
fi

# Aller dans le dossier Terraform
cd /home/azureuser/projetfe/iac-devops/terraform

# Initialiser Terraform
echo "🔧 Initialisation de Terraform..."
terraform init

# Planification
echo "📋 Planification Terraform..."
terraform plan

# Appliquer les changements automatiquement
echo "⚙️ Application des changements Terraform..."
terraform apply -auto-approve

echo "✅ Terraform deployment finished successfully."
