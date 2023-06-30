# Service Oriented Experiment

System for experimenting with service oriented architecures.  It uses docker with the services on their own network each of the root folders contains an independent product that is part of the system.

## Products

- dns
- identity

### dns

Self hosted dns server that all the services use as their dns server. This is an off the shelf rust based implementaion of dns that is fairly simple to configure.

### identity

Identity management and authentication. This is an off the shelf self hosted identity management system.


## Gettings started

Each service folder contains the following setup scripts:

- setup.sh   - setup the docker network and services 
- teardown.sh - teardown the docker services and network

__n.__ - to allow routing between the different docker networks custom iptable rules needed to be added as docker diables this by default. 
