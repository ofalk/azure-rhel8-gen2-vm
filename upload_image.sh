az disk delete --name rhel-8 -g myresourcegroup -y
az disk create --hyper-v-generation V2 -g myresourcegroup -n rhel-8 --os-type Linux -l westus2 --for-upload --upload-size-bytes $(wc -c rhel-8.2.vhd|awk '{ print $1 }') --sku standard_lrs
SASURI=$(az disk grant-access -n rhel-8 -g myresourcegroup --access-level Write --duration-in-seconds 86400 --query [accessSas] -o tsv)
azcopy copy $(pwd)/rhel-8.2.vhd $SASURI --blob-type PageBlob
az disk revoke-access -n rhel-8 -g myresourcegroup

az image create -g myresourcegroup -n rhel-8 --os-type Linux --hyper-v-generation V2 --source rhel-8
