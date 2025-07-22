#!/usr/bin/env python3
import json
import sys

with open("ansible/ips.json") as f:
    ip_data = json.load(f)

hosts = ip_data["ips"]["value"]

inventory = {
    "all": {"children": {"webservers": {"hosts": list(hosts.keys())}}},
    "_meta": {"hostvars": {name: {"ansible_host": ip} for name, ip in hosts.items()}},
}

if len(sys.argv) == 2 and sys.argv[1] == "--list":
    print(json.dumps(inventory, indent=2))
elif len(sys.argv) == 3 and sys.argv[1] == "--host":
    hostname = sys.argv[2]
    print(json.dumps(inventory["_meta"]["hostvars"].get(hostname, {}), indent=2))
else:
    print("Usage: --list or --host <hostname>", file=sys.stderr)
    sys.exit(1)
