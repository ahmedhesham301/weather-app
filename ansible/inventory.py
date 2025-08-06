#!/usr/bin/env python3
import json
import sys
import os
with open("terraform/output.json") as f:
    hosts = json.load(f)

hosts_dict = {
        "_meta": 
        {
            "hostvars":
            {

            }    
        }, 
        "all": 
        {
           "children": 
            [
                "webservers"
            ]
        },
        "webservers": 
        {
            "hosts":
            [

            ]
        }
        
}

bastion_ip = hosts["bastion"]["value"]["public_ip"]["bastion"]
ssh_key_location = os.environ["sshKey"]

for name,ip in hosts["webservers"]["value"]["private_ips"].items():
    hosts_dict["_meta"]["hostvars"][name] = {
        "ansible_user": "ec2-user",
        "ansible_host": ip,
        "ansible_ssh_private_key_file": ssh_key_location,
        "ansible_ssh_common_args": f"-o 'ProxyCommand=ssh -o StrictHostKeyChecking=no -i {ssh_key_location} -W \"%h:%p\" -q ec2-user@{bastion_ip}'",
    }
    hosts_dict["webservers"]["hosts"].append(name)


if len(sys.argv) == 2 and sys.argv[1] == "--list":
    print(json.dumps(hosts_dict, indent=2))
elif len(sys.argv) == 3 and sys.argv[1] == "--host":
    print(json.dumps(hosts_dict["all"]["webservers"][sys.argv[2]]), indent=2)
