# nuvm

Virtualbox cli manager

# Dependencies

``` 
VirtualBox
genisoimage
qemu
axel
```

# Configure

```bash
sudo ln -s -f full/path/nuvm /usr/local/bin
```

# Commands
```bash
$ nuvm
list
|--os                   List virtualbox OS's templates
|--images               List images availables
|--runningvms           List running VM's
|--vms                  List all your VM's
vm
|--stop                 Stop a VM 
|--create               Create a VM
|--delete               Delete a VM
|--inspect              Inspect a VM
|--start                Start a VM
```

# Images

```
You can add new images editing the file nuvm.d/.config/images.json
```

# Cloud Init

```
You can create your cloud-init scripts, based on cloud-init/default.
Create a folder with the name of your cloud-init, and copy the files:
user-data
meta-data
inside it, the nuvm replaces the string HOSTNAME, so don't change it.
```

# VM Access

```
All vms run with nat, so to get access to then, the nuvm create a port forward.
When you create a vm especifie a port from your host to bind the vm ssh, when the
vm starts, you can access the vm like this
```
```bash
ssh nuvm@127.0.0.1 -p 2222
```
```
by default nuvm create a user nuvm with password secret, you can change it on your cloud-init script
```

# Starting VM
 
```bash
nuvm vm create -o Linux_64 -i centos-7 -H system-test -p 2222 -C common
ssh nuvm@127.0.0.1 -p 2222 -i ~/.ssh/maquinas
```

# ToDo
```
Image resize
Create Port Forwarding to specific vms
```
