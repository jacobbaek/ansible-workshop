# ansible workshop

# who can use this script
anyone who want to know the ansible playbook.

# how can use this script
first, you can make a VM instances that is running on KVM.
second, run playbook on the deploy_multipackage directory

```
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.ini playbook.yaml -vvvv
```

"ANSIBLE_HOST_KEY_CHECKING=False" is passing the host key checking.
so you encountered input situation, you should use "ANSIBLE_HOST_KEY_CHECKING=False".
