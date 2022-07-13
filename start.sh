mkdir ./data/netdata/config -p
mkdir ./data/netdata/lib -p
mkdir ./data/netdata/cache -p
chown -R 201 ./data/netdata
mkdir ./data/nexus3 -p
chown -R 200 ./data/nexus3
docker compose up --remove-orphans -d
