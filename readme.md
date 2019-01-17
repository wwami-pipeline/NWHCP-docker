# Set up

## Requirements

- Node.js
- Go 1.11+
- Docker

## Clone and guide yourself to desired branch
- Be sure to put those repos(Front-End, pipeline-db) in the same folder e.g. capstone/

## Install dependencies

cd to Front-End and run
```
npm install
```

cd to pipeline-server and run
```
go mod vendor
```

## For development

1.  Make sure you have mongoDB running on port 27017(defalut) by running
```
docker-compose -f docker-compose-db.yml up
```
in waypoint folder
2.  Front-end: npm start
3.  Back-end: go run main.go
4.  No need to run 2 & 3 in containers

## Create Production build

In this directory, just run
```
docker-compose up
```

To rebuild, run:
```
docker-compose up --build
```

To clean junk, run:
```
docker system prune -f
```

# Todo

1.  Add authentication for mongoDB
2.  Rewrite APIs in go
3.  Create web form?
