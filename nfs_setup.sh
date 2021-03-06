#!/bin/bash

set -e

mounts="${@}"

for mnt in "${mounts[@]}"; do
  src=$(echo $mnt | awk -F':' '{ print $1 }')
  mkdir -p $src
  echo "$src *(rw,sync,no_subtree_check,fsid=0,no_root_squash)" >> /etc/exports
done

echo "nfs 2049/tcp" >> /etc/services
echo "nfs 2049/udp" >> /etc/services

exec runsvdir /etc/sv
