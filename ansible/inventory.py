import json

with open("output.json") as f:
    hosts = json.load(f)

hosts_dict = {"all": {"hosts": {}, "children": {"webservers": {"hosts": {}}}}}

for name,ip in hosts["ips"]["value"].items():
    hosts_dict["all"]["hosts"][name] = {"ansible_host": ip}
    hosts_dict["all"]["children"]["webservers"]["hosts"][name] = None
print(json.dumps(hosts_dict, indent=2))
