set -e

yum -y install git
yum -y install epel-release
yum -y install ansible
git clone https://github.com/juliankelly24/ansible ~/ansible

function run_ansible {
ansible-playbook -i 'localhost ansible_connection=local,' ~/ansible/create_users.yml
}
