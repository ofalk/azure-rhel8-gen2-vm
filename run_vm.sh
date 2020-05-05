az storage account create -n lkernatstor -g myresourcegroup -l westus2 --sku Standard_LRS

az vm create  \
    --resource-group myresourcegroup \
    --location westus2 \
    --name rhel-8 \
    --image rhel-8 \
    --boot-diagnostics-storage lkernatstor \
    --admin-username cloud-user \
    --ssh-key-value @/root/.ssh/id_rsa.pub
