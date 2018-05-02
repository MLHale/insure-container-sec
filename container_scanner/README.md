### container_scanner Documentation

##### docker-compose
docker-compose is utilized to start four containers simultaneously. The command to start them is ```docker-compose up```, although this is not recommend. This command should only be run by the setup.py file.

If you are finished with the scanner and do not plan on running it again, you can shut everything down by running ```docker-compose down``` from the directory with the docker-compose.yml file.

##### setup.py
The setup.py file will start everything if you respond correctly to the prompts. Running this is the correct way to start the scanning process.

It will first ask if you are scanning a local container. If you say yes, it will ask you for a container name, and if it is an ubuntu container. Regardless, the docker-cis benchmark will always be run against the local host, and if its an ubuntu container, the cis benchmark will be copied to it and ran. ```When your scanning a local container, it will be added to the docker network of the containers in the docker-compose.yml file and will not be removed until you run the script again. If you do not plan on doing so, you should remove it manually. ```

If you are not scanning a local container, you will be asked for an ip address, and only nmap and OpenVAS will be run against the host.
