image=$(ls -1tr /var/lib/libvirt/images/rhel*|tail -1)
sudo qemu-img convert -f qcow2 -O raw $image rhel-8.2.raw
sudo chown $(whoami) *.raw

MB=$((1024*1024))
size=$(qemu-img info -f raw --output json "rhel-8.2.raw" | \
	gawk 'match($0, /"virtual-size": ([0-9]+),/, val) {print val[1]}')

rounded_size=$((($size/$MB + 1)*$MB))
qemu-img resize -f raw rhel-8.2.raw $rounded_size

qemu-img convert -f raw -o subformat=fixed -O vpc rhel-8.2.raw rhel-8.2.vhd

qemu-img convert -f raw -o subformat=fixed,force_size -O vpc rhel-8.2.raw rhel-8.2.vhd
