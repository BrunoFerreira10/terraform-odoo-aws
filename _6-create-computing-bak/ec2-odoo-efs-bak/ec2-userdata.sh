#!/bin/bash
apt-get install nfs-common -y

sudo touch /etc/odoo.conf
sudo bash -c 'cat <<EOF > /etc/odoo.conf
[options]
; Database operations password:
admin_passwd = 123456
db_host = ${}
db_port = 5432
db_user = odoo
db_password = False
addons_path = /opt/odoo/odoo/addons,/opt/odoo/odoo-custom-addons
EOF'