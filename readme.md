# Set up

## IMPORTANT!

You should never publish mongoDB port 27017 (by -p 27017:27017) in production, or anyone can have access to our mongoDB database.

Instead, expose 27017 only, so that it's only accessible in this docker network. You can do so in dockerfile or docker-compose.yml configurations.

## Requirements

- Node.js
- Go 1.11+
- Docker

## Clone and guide yourself to desired branch
- Be sure to put those repos(all start with NWHCP) in the same folder e.g. capstone/

## Install dependencies

See setup.sh

Or just run it

## For development

1.  Make sure you have mongoDB running on port 27017(defalut) by running
```
docker-compose -f docker-compose-db.yml up
```
in waypoint folder
2.  Front-end: npm start
3.  Back-end: go run main.go
4.  No need to run 2 & 3 in docker containers

## Test Production build on your local machine
Firstly create front end production build, in Front-End directory, run:
```
npm run build
```

Then in this directory, just run
```
docker-compose up
```

Now you can go to http://localhost

To rebuild, run:
```
docker-compose up --build
```

To clean junk, run:
```
docker system prune -f
```
