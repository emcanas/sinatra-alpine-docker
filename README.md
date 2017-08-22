# sinatra-on-docker-machine

This is an Apline-Sinatra (simple Hello World application) docker container, that can be  deployed locally or on a remote server provided by virtualbox and use docker with "Docker-machine".

I have create a docker image, where I have defined my environment (Alpine as OS, Ruby and Sinatra as software and hello-world.rb as application). This environment is defined on the dockerfile (see dockerfile.md).

By building and running the image I can obtain de container; so the application is deployed and running. Although this is a simple application, I have decided to use "docker-compose" to simplify the commands to execute (see docker-compose.md).


***
**Pre-requisites**

Before download and running the project, be sure to install the next tools:

 - Docker: https://www.docker.com/
 - Docker Compose: https://docs.docker.com/compose/install/
 - Docker Machine: https://docs.docker.com/machine/install-machine/
 - VirtualBox: https://www.virtualbox.org/ (Optional)

The following instructions are based on Ubuntu 16.04; some other changes may be required according to your OS.

***
#### **1 Running the container locally** ##
 
1. Download https://github.com/emcanas/sinatra-on-docker-machine.git locally.
2. Build and run the container:  **docker-compose build**
	
		cd .../sinatra-on-docker-machine/apps
		docker-compose build

		
	If there are no errors, start running the container in background (-d): **docker-compose up -d**
	
		docker-compose up -d


3. Open a browser and check on localhost (port 80)

***
####  **2 Running the container on a VM**  ##
 
1. Download https://github.com/emcanas/sinatra-on-docker-machine.git locally.
2. Create a docker-machine: **docker-machine create --driver virtualbox *machine_name* **(let's say vm-sinatra)

		cd .../sinatra-on-docker-machine/apps
		
		# Creating the vitural machine
		docker-machine create --driver virtualbox vm-sinatra
		
		# If successfull, check data connection
		docker-machine env vm-sinatra
		(...)
		# Set up a route on your /etc/hosts with the new host (see step 5)
		export DOCKER_HOST="tcp://192.168.99.102:2376" 
		(...)

3. Target the new machine to use it when working with docker commands:
		 
		eval $(docker-machine env vm-sinatra)
		
		# Confirm:
		docker-machine active
		
4. Build and run:

		docker-compose build
		docker-compose up -d

5. Set up the route on your hosts: **sudo vim /etc/hosts** 

		# Check the IP of your VM
		echo $DOCKER_HOST
		tcp://192.168.99.102:2376
		
		sudo vim /etc/hosts
		192.168.99.102  vm-sinatra

6. Open a browser and check it! http://vm-sinatra/

***
#### **3 sinatra.sh** ##

All the instructions mentioned above can be executed running this simple bash. 

- Deploy it locally (option 1):

		./sinatra.sh 
		 
		 Sinatra application deployed with Docker
		 ----------------------------------------
		 
		          1. Locally (http://localhost:80)
		          2. Virtual server (virtualbox on docker-machine)
		 
		 Choose your option:  1
		 
		 (...)
		 
		 Successfully built 5358ea35f39e
		 Successfully tagged sinatra-hello:latest
		 apps_ruby-sinatra_1 is up-to-date
	 

	Access to sinatra web in the browser on http://localhost: 

- Deploy it on VM (option 2):  
	 
		./sinatra.sh 
		 
		 Sinatra application deployed with Docker
		 ----------------------------------------
		 
		          1. Locally (http://localhost:80)
		          2. Virtual server (virtualbox on docker-machine)
		 
		  Choose your option: 2
		  Running docker on a VM
		  Please, introduce the name of the VM: vm-sinatra
		  The vm already exists! Skipping docker-machine create ....
	      
	       	 (...)
	       	 	
	      Successfully built 95ca1cd79810
	      Successfully tagged sinatra-hello:latest
	      apps_ruby-sinatra_1 is up-to-date
		
	  	  
	Access to sinatra web in the browser on http://vm-sinatra 




 ***
####References and other links

- Sinatra: http://www.sinatrarb.com/
- Docker images: https://hub.docker.com/ (image based on Alpine Linux used in this project https://hub.docker.com/_/alpine/) 

 ***
 