#!/usr/bin/env python3
import json
import sys

with open("ansible/ips.json") as f:
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
                "servers"
            ]
        },
        "servers": 
        {
            "hosts":
            [

            ]
        }
        
}

for name,ip in hosts.items():
    hosts_dict["_meta"]["hostvars"][name] = {"ansible_host": ip}
    hosts_dict["servers"]["hosts"].append(name)


if len(sys.argv) == 2 and sys.argv[1] == "--list":
    print(json.dumps(hosts_dict, indent=2))
elif len(sys.argv) == 3 and sys.argv[1] == "--host":
    print(json.dumps(hosts_dict["all"]["webservers"][sys.argv[2]]), indent=2)
