
# DOCKER


The user wants to run the application in the app directory with docker. Write a script to help him.



## Useful Docker commands


To manually create the container you can execute:

docker build --tag="tecnickcom/natstestdev" .
To log into the newly created container:

docker run -t -i tecnickcom/natstestdev /bin/bash
To get the container ID:

CONTAINER_ID=`docker ps -a | grep tecnickcom/natstestdev | cut -c1-12`
To delete the newly created docker container:

docker rm -f $CONTAINER_ID
To delete the docker image:

docker rmi -f tecnickcom/natstestdev
To delete all containers

docker rm $(docker ps -a -q)
To delete all images

docker rmi $(docker images -q)


  
## Usage

Usage:
  natstest [flags]
  natstest [command]

Available Commands:
  version     print this program version

Flags:
  -c, --configDir     string  Configuration directory to be added on top of the search list
  -l, --logLevel      string  Log level: EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFO, DEBUG
  -n, --natsAddress   string  NATS bus Address (nats://ip:port) (default "nats://127.0.0.1:4222")
  -s, --serverAddress string  HTTP API URL (ip:port) or just (:port) (default ":8081")

Use "natstest [command] --help" for more information about a command.

  