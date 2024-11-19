# Useful commands

```bash
terraform output -raw instance_public_ip | \
  awk '{ print "all:\n  hosts:\n    webserver:\n      ansible_host: " $1 "\n      ansible_user: ubuntu\n      ansible_become: true\n      ansible_ssh_private_key_file: ./secrets/my-key.pem" }' > ./ansible/my-inventory.yml
``` 

```
cd ansible
ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i my-inventory.yml playbook.yaml
```