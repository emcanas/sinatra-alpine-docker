#!/bin/bash
set -e

APP_PATH=apps

echo " "
echo " Deploy Sinatra application on VM with Docker"
echo " --------------------------------------------"
echo " "

echo -n " Please, provide the name of the image: "
read image

echo -n " Please, introduce the name of the VM (if the machine doesn't exists, a new one will be created): "
read vmachine

cd $APP_PATH

container=$(docker ps | grep $image:latest | awk '{print $1}')

if [ $container ]
then

    echo -e ""
    echo -e " A container of this image is already running, please stop it! Run: docker stop $container"
    echo -e " Use 'docker ps' for help"
    echo -e " "
    exit 1
fi

echo -e " "
echo -e " ===> Build in process .... "
docker build -t $image .

vmexists=$(docker-machine status $vmachine 2> /dev/null || echo 0)

if [ $vmexists = "0" ]
then
    echo -e " "
    docker-machine create --driver virtualbox $vmachine
else
    echo -e " The vm already exists! Skipping docker-machine create ...."
fi

echo -e " "
echo -e "VM details: "
echo -e "============"

docker-machine env $vmachine

echo -e " "
echo -e "  ===> Run in process... (background mode)"
docker run -d -p 80:80 $image

echo -e " "
echo -e "DONE! Set up a route (/etc/hosts) before access sinatra web on http://$vmachine "
echo -e " "

exit 0

