#Dockerfile

The Dockerfile contains all the instructions that will allow you to build the image and set up the environment for your application. In general, you need a OS, packages and complementary configurations and the application code.

For this project, I am using Alpine as OS, some ruby packages and instructions, and the command line to launch our ruby file.

See below more details about the content of the file.

***
###Dockerfile content

**Alpine**
I have chosen this distribution of Linux, Alpline, to obtain a small image. It is possible to build it in on Ruby ("FROM ~~~~ruby:lastest-version") but it would require around 1GB. Alpine is a nice tiny alternative.

Any dockerfile must contain the keyword "FROM" to initialise a new build from a *based image* (an image with no parent). It will contain all the necessary to contruct the OS or software to run the application. You can find several of those *base images* here: https://hub.docker.com/

	FROM alpine:3.2

**Ruby packages and dependencies**

I am updating and adding the needed packages to run helloworld.rb. The instruction is *RUN*.

	ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base
	ENV RUBY_PACKAGES ca-certificates ruby ruby-io-console ruby-bundler
	
	RUN apk update && \
		apk upgrade && \
		apk add $BUILD_PACKAGES
	
	RUN apk add $BUILD_PACKAGES
	RUN apk add $RUBY_PACKAGES

Configuring a working directory for the scripts and files.

	# Copy local files to the image
	RUN mkdir $APP_HOME
	WORKDIR $APP_HOME
	COPY * $APP_HOME

Cleanning the cache after installation! Alpine stores the cache in the following folder:

	 RUN rm -rf /var/cache/apk/*
	 
Providing an environment for Ruby and install sinatra.

	RUN bundle install
	RUN gem install sinatra --no-document

**Ports** 

By the instruction *EXPOSE* I am telling to docker in which port the container will be listening on. However, this is not enough to be accessible. The access will be granted during the run of the image with the option -p (*docker run -p 80:80 imageName*).

	ENV PORT 80
	EXPOSE 80

By default, Sinatra is on 4567 port (https://github.com/sinatra/sinatra).

**Running ruby file**

The instruction to execute when running the image is the provided sinatra "helloworld" application:

	CMD ["ruby", "helloworld.rb"]

***
	 


	
