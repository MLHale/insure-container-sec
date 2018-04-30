build: Dockerfile *
	docker build -t nmap.img .

start: build
	-docker run -v /home/capstone/docker-volumes/nmap:/outputs -d -t --name nmap.cont nmap.img

stop:
	-docker container stop nmap.cont

clean:
	-docker container stop nmap.cont
	-docker container rm nmap.cont
