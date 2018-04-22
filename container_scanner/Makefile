build: Dockerfile *
	docker build -t master.img .

start: build
	-docker run -d  -v /home/capstone/docker-volumes/openvas:/outputs --name master.cont master.img
	

stop:
	-docker container stop master.cont

clean:
	-docker container stop master.cont
	-docker container rm master.cont
