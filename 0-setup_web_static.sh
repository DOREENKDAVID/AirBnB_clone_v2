#!/usr/bin/env bash
#script that sets up your web servers for the deployment of web_static
apt get -y update
apt get install -y nginx

# create the following direcories and files
mkdir -p /data/web_static/shared/
mkdir -p /data/web_static/releases/test/
touch /data/web_static/releases/test/index.html
echo "Hello configuration successful" > /data/web_static/releases/test/index.html

# Check if /data/web_static/current exists and remove it
if [ -d "/data/web_static/current" ]
then
	sudo rm -rf /data/web_static/current
fi

# create a symbolic link 
ln -sf /data/web_static/releases/test/ /data/web_static/current

# give ownership of /data to ubuntu user and group

chown -hR ubuntu:ubuntu /data

#Update the Nginx configuration to serve the content

sed -i '38i\\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default

#restart Nginx after updating the configuration:
service nginx restart
