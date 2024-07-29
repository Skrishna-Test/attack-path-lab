#! /bin/bash
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

#This  command will generate an authorization token (Only valid for 1 hour)
json_auth_data="$(printf '{ "username": "%s", "password": "%s" }' "${PRISMA_ACCESS_KEY}" "${PRISMA_SECRET_KEY}")"

token=$(curl -sSLk -d "$json_auth_data" -H 'content-type: application/json' "$PCC_URL/api/v1/authenticate" | python3 -c 'import sys, json; print(json.load(sys.stdin)["token"])')

sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl stop tomcat9.service
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo docker-compose -f /home/ubuntu/app/docker-compose.yml up --build -d