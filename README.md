# sinatra-on-docker-machine

This is a  Apline-Sinatra docker image, based on a simple Hello World ruby application. 

All the environment needed to run the sinatra helloworld.rb app is defined in the docker image; and the docker image is encoded in a small file called "dockerfile". Here, I provide the OS (Alpine), Ruby, Sinatra and other packages or configurations, and finally the code of the application (helloworld.rb).

The built of the dockerfile will provide an image; and the run of the image will provide a container (i.e. a container is a running instance of an image).

To deploy my application, I have choosen a VM created with Virtualbox. The tool docker-machine is very useful to work with docker commands while pointing to this VM. It is also possible to run it locally.

The instructions below depict step by step the whole process (build and run). They are based on Ubuntu 16.04; some changes may be required according to your OS. 
 
***
**Pre-requisites**

Before download and running the project, be sure to install the next tools:

 - Docker: https://www.docker.com/
 - Docker Machine: https://docs.docker.com/machine/install-machine/
 - VirtualBox: https://www.virtualbox.org/ (Optional)

***
#### **Step by step** ##
 
1. Download https://github.com/emcanas/sinatra-on-docker-machine.git locally.
2. Build the image from the dockerfile:  **docker build**
	
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
#### **To improve** ##

The virtual host must be secured and locked down. As user docker, the ssh access is granted without password.

	docker-machine ssh vm-sinatra
	                        ##         .
	                  ## ## ##        ==
	               ## ## ## ## ##    ===
	           /"""""""""""""""""\___/ ===
	      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
	           \______ o           __/
	             \    \         __/
	              \____\_______/
	 _                 _   ____     _            _
	| |__   ___   ___ | |_|___ \ __| | ___   ___| | _____ _ __
	| '_ \ / _ \ / _ \| __| __) / _` |/ _ \ / __| |/ / _ \ '__|
	| |_) | (_) | (_) | |_ / __/ (_| | (_) | (__|   <  __/ |
	|_.__/ \___/ \___/ \__|_____\__,_|\___/ \___|_|\_\___|_|
	Boot2Docker version 17.06.1-ce, build HEAD : 80114bc - Fri Aug 18 17:58:04 UTC 2017
	Docker version 17.06.1-ce, build 874a737
	docker@vm-sinatra:~$ 
	
Removing the access to docker user or adding a password would disable some checks from docker-machine; however, the web server would be accessible. This is an issue to investigate and improve on this project.

Alternatively, I have followed some basic security rules linked to a docker container (see References to extra information), as using a base image from a trusted repository (hub.docker.com); or using Linux based systems. However, I need to continue working to lock down and secure the server, and the container too.


***
#### References ##

- Sinatra: http://www.sinatrarb.com/
- Docker images: https://hub.docker.com/ (image based on Alpine Linux used in this project https://hub.docker.com/_/alpine/) 
- Build a Minimal Docker Container for Ruby Apps: https://blog.codeship.com/build-minimal-docker-container-ruby-apps/

Security:

- 5 tips for securing your Docker containers: http://www.techrepublic.com/article/5-tips-for-securing-your-docker-containers/
- Docker Security – 6 Ways to Secure Your Docker Containers: https://www.sumologic.com/blog/security/securing-docker-containers/ 
- The Ultimate Guide to Container Security: https://www.twistlock.com/2017/07/06/ultimate-guide-container-security/
***
 
