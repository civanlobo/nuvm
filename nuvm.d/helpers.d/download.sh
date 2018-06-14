#!/bin/bash -u

function get_url(){
  image_url=$(cat $nuvm_path/nuvm.d/.config/images.json | jq -r ".\"$image_name\"")
  echo $image_url
}

function get_image(){
  get_url
  echo "Downloading image of $image_name..."
  axel -o $nuvm_path/images/$image_name.raw $image_url
  echo "Download completed."
  convert
}

function convert(){
  vm_path=$nuvm_path/vms/$hostname
  mkdir -p $vm_path
  cp $nuvm_path/images/$image_name.raw $vm_path/$hostname.raw
  raw_image=$vm_path/$hostname.raw
  vdi_image=$vm_path/$hostname.vdi
  qemu-img convert -O vdi $raw_image $vdi_image
  #VBoxManage convertdd $raw_image $vdi_image --format VDI
  rm $raw_image
}

function check_image(){
  exists=$(cat $nuvm_path/nuvm.d/.config/images.json | jq "has(\"$image_name\")")
  if [[ $exists == true ]];then
    get_image
  else
    echo "Image does not exist."
    exit
  fi

}

function check_local(){
  exists="$nuvm_path/images/$image_name.raw"
  if [[ -f $exists ]];then
    read -p "You have a image of $image_name already, do you want to download a new one?[y/N]"
    if [[ $REPLY =~ ^[Yy]$ ]];then
      get_image
    else
      convert
    fi      
  else
    get_image
  fi
}

function download(){
  image_name=$1
  hostname=$2
  check_local
}

