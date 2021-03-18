cd NWHCP-docker/

npm install

npm run build

cd ../NWHCP-server/

go mod vendor

cd ../NWHCP-docker/

docker-compose up --build