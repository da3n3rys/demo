echo "Generating local self-signed certificates..."

docker build -t localcerts:latest ./testing/

docker run -it --rm \
  -v /etc/certs:/opt/cert-export \
  -e LS_CLIENTNAME=$LS_CLIENTNAME \
  -e LS_SERVERNAME=$LS_SERVERNAME \
  localcerts:latest

mkdir -p /etc/letsencrypt/live/${LS_SERVERNAME}/

ls /etc/certs/

cat /etc/certs/${LS_SERVERNAME}.crt > /etc/letsencrypt/live/${LS_SERVERNAME}/fullchain.pem

cat /etc/certs/${LS_SERVERNAME}.key >> /etc/letsencrypt/live/${LS_SERVERNAME}/privkey.pem

echo ">>>Looking at letsencrypt dir..."
tree /etc/letsencrypt

docker rmi localcerts
