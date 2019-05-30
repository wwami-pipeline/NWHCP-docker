# Docker configuration for NWHCP project

## IMPORTANT!

You should NEVER publish mongoDB port 27017 (by ```-p 27017:27017```) in production, or anyone can have access to our mongoDB database.

Instead, expose 27017 only, so that it's only accessible in this docker network. You can do so in ```Dockerfile``` or ```docker-compose.yml``` configurations.

## Requirements

- Node.js
- Go 1.11+
- Docker
  
Docker-compose is used to depoly this system, this might be new to you, but it's the same as all those ```docker build``` and ```docker run``` stuff. 

Imagine if you want to run 6 containers, all those ```docker build```, ```docker run```, port publishing, env var setting could be really long and troublesome. Now with docker-compose, we can include those configurations in one docker-compose.yml file, and simply run ```docker-compose up``` to get those containers running. 

If you are lost, just refer to docker-compose documentaion at [https://docs.docker.com/compose/gettingstarted/](https://docs.docker.com/compose/gettingstarted/).

# Set up
## Clone and guide yourself to desired branch
Be sure to put those repos(all start with NWHCP) in the same folder e.g. capstone/

## Install dependencies

See setup.sh

Or just run it

## For development (back-end)

1.  Make sure you have mongoDB running on port 27017(defalut) by running
```
docker-compose up
```

WARNING: only use docker-compose up on your local machine. OR you will be exposing un-secured mongoDB in production. 

1.  Front-end: ```npm start``` (if you want to do some front-end)
2.  Back-end: ```go run main.go```
3.  Data-importing service: ```python main.py```
4.  No need to run in docker containers. If it works without docker, you can of course get it working with docker.

## For development (front-end)
1. Run ```docker-compose up```, you will have all services running on http://localhost.
2. Run ```npm start```, React .env files are already set up, if you are in dev mode, it will call APIs on http://localhost. Feel free to change .env.development file of react to set API point to wherever your server is running.

## Test Production build on your local machine
Firstly create front end production build, in nwhcp-frint_end directory, run:
```
npm run build
```

This will create React production build.

Then in this directory (nwhcp-docker), just run
```
docker-compose up
```

Now you can go to http://localhost

To rebuild, run (DON'T forget to build front-end static pages again if you changed something there):
```
docker-compose up --build
```

To clean junk, run:
```
docker system prune -f
```

## Deploy in VM

### Build images and push

Build your react app running  ```npm run build```

Then in both ```docker-compose.yml``` and ```docker-compose-prod.yml```, change image name from ```{my docker hub user name}/{image name}``` (e.g. ```uwjake/nwhcp-front-end```) to ```{your docker hub user name}/{image name}``` so that you can push those images to your docker hub account.

Then in this directory (NWHCP-docker) on your local machine, run:
```
docker-compose build
docker-compose push
```
This will build all images specified in docker-compose.yml and push them to docker hub. (Same as docker build, docker push commands)

### Now ssh into VM
You must do everything with sudo there.

Clone/pull this repo somewhere, now it's in /NWHCP/NWHCP-docker.

Before deploying, you have to stop current running services.

cd into this folder, pull so that you have lastest reop and run:
```
sudo docker-compose -f docker-compose-prod.yml kill 
```

Or just simply rm running containers.

Or you can also remove all those docker images to make sure you are using the lastest images.

Make sure your ```docker ps``` is empty list.

Then start services by running:

```
sudo docker-compose -f docker-compose-prod.yml up -d
```
(-f means use a certain file other than default docker-compose.yml)

This will pull the images and run in detached mode.

Now the NWHCP website should be up and running.

# System Design Diagram
![Diagram](https://raw.githubusercontent.com/wwami-pipeline/NWHCP-docker/master/system_design.png "Diagram")