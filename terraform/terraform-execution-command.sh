#!/bin/bash
#Comandos para rodar:
# source /media/pledo/work/python312-venv/bin/activate

terraform fmt -diff -recursive && terraform validate;checkov -d .
export AWS_SHARED_CREDENTIALS_FILE="/media/pledo/work/entrevistas/secrets/aws.config";export AWS_DEFAULT_PROFILE="test1"; terraform plan
