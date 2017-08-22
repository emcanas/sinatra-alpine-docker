# sinatra-on-docker-machine

This is a  Apline-Sinatra docker image, based on a simple Hello World ruby application. 

All the environment needed to run the sinatra helloworld.rb app is defined in the docker image; and the docker image is encoded in a small file called "dockerfile". Here, I have provided the OS (Alpine), Ruby, Sinatra and other packages or configurations, and finally the code of the application (helloworld.rb).

The built of the dockerfile will provide an image; and the run of the image will provide a container (i.e. a container is a running instance of an image).

To deploy my application, I have choosen a VM created with Virtualbox.  The tool docker-machine is very useful work with docker commands while pointing to this VM. It is possible also to run it locally.


All the instructions are described allong this documentation and can be executed step by step to follow the whole process (build and run). On the other side, I have coded a simple script (sinatra.sh) that execute all these commands for you (sinatra.sh). 
 
***
**Pre-requisites**

Before download and running the project, be sure to install the next tools:

 - Docker: https://www.docker.com/
 - Docker Machine: https://docs.docker.com/machine/install-machine/
 - VirtualBox: https://www.virtualbox.org/ (Optional)

The following instructions are based on Ubuntu 16.04; some other changes may be required according to your OS.

***
#### **Step by step** ##
 
1. Download https://github.com/emcanas/sinatra-on-docker-machine.git locally.
2. Build the image from the dockerfile:  **docker build**
	
		cd apps
		docker build -t helloworld .
		
		# docker build -t image_name PATH
		# -t (tag) to give a name to the image
		# PATH:  Path where the dockerfile is located
	
5. Set up a virtual server using Virtualbox and let docker point to it (let's name it vm-sinatra)

		# 1. Check existing machines

		docker-machine ls 
		NAME             ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER        ERRORS
		sinatra-host     -        virtualbox   Running   tcp://192.168.99.100:2376           v17.06.1-ce   
		sinatra-host-a   -        virtualbox   Running   tcp://192.168.99.101:2376           v17.06.1-ce 

		# 2. Create a new one
		docker-machine create --driver virtualbox vm-sinatra
		
		# Check status of the machine: 
		docker-machine status vm-sinatra
		Running
		
		# Point docker to the new vm and confirm
		 eval $(docker-machine env vm-sinatra)
		 docker-machine active
		
4. Run  the image to create and start the container

		docker run -d -p 80:80 helloworld
		
		# -p : ports specification
		# 80:80 (from the host:from the container)
		# helloworld : name given previously to the build 

5. Set up the route on your hosts: **sudo vim /etc/hosts** 

		# Check the IP of your VM
		echo $DOCKER_HOST
		tcp://192.168.99.102:2376
		
		sudo vim /etc/hosts
		192.168.99.102  vm-sinatra

6. Access to sinatra web in the browser on http://vm-sinatra 

***
#### **sinatra.sh** ##

All the instructions mentioned above can be executed running this simple bash. 


		./sinatra.sh 
		 
		Deploy Sinatra application on VM with Docker
 		--------------------------------------------
 
		Please, provide the name of the image: helloworld
		Please, introduce the name of the VM (if the machine doesn't exists, a new one will be created): vm-sinatra

Set up the route following the previous step (v) , then access to sinatra web in the browser on http://vm-sinatra 


 ***
####References and other links

- Sinatra: http://www.sinatrarb.com/
- Docker images: https://hub.docker.com/ (image based on Alpine Linux used in this project https://hub.docker.com/_/alpine/) 

 ***
 