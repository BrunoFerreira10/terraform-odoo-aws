#!/bin/bash
sudo apt update -y

sudo apt install -y build-essential wget python3-dev python3-venv python3-wheel \
  libfreetype6-dev libxml2-dev libzip-dev libldap2-dev libsasl2-dev \
  python3-setuptools node-less libjpeg-dev zlib1g-dev libpq-dev libxslt1-dev \
  libldap2-dev libtiff5-dev libjpeg8-dev libopenjp2-7-dev liblcms2-dev \
  libwebp-dev libharfbuzz-dev libfribidi-dev libxcb1-dev

# Bug fix
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_amd64.deb
sudo dpkg -i libssl1.1_1.1.0g-2ubuntu4_amd64.deb

sudo useradd -m -d /opt/odoo -U -r -s /bin/bash odoo
sudo apt install postgresql -y
sudo su - postgres -c "createuser -s odoo"

sudo wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb
sudo apt install ./wkhtmltox_0.12.5-1.bionic_amd64.deb -y

sudo -u odoo /bin/bash -c "git clone https://www.github.com/odoo/odoo --depth 1 --branch 17.0 /opt/odoo/odoo"
sudo -u odoo /bin/bash -c "python3 -m venv /opt/odoo/odoo-venv"

sudo -u odoo /bin/bash -c "source /opt/odoo/odoo-venv/bin/activate && pip3 install wheel"
sudo -u odoo /bin/bash -c "sed -i 's/greenlet==2.0.2/greenlet==3.0.3/g' /opt/odoo/odoo/requirements.txt"
sudo -u odoo /bin/bash -c "source /opt/odoo/odoo-venv/bin/activate && pip3 install -r /opt/odoo/odoo/requirements.txt"
sudo -u odoo /bin/bash -c "mkdir /opt/odoo/odoo-custom-addons"

sudo touch /etc/odoo.conf
sudo bash -c 'cat <<EOF > /etc/odoo.conf
[options]
; Database operations password:
admin_passwd = 123456
db_host = False
db_port = False
db_user = odoo
db_password = False
addons_path = /opt/odoo/odoo/addons,/opt/odoo/odoo-custom-addons
EOF'

sudo touch /etc/systemd/system/odoo.service
sudo bash -c 'cat <<EOF > /etc/systemd/system/odoo.service
[Unit]
Description=Odoo
Requires=postgresql.service
After=network.target postgresql.service
[Service]
Type=simple
SyslogIdentifier=odoo
PermissionsStartOnly=true
User=odoo
Group=odoo
ExecStart=/opt/odoo/odoo-venv/bin/python3 /opt/odoo/odoo/odoo-bin -c /etc/odoo.conf
StandardOutput=journal+console
[Install]
WantedBy=multi-user.target
EOF'

sudo systemctl daemon-reload
sudo systemctl enable --now odoo
sudo systemctl status odoo