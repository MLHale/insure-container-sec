build: Dockerfile *
	docker build -t container2.img .

start: build
	-docker run -d -p 5555:22 -t --name container2.cont container2.img

stop:
	-docker container stop container2.cont

clean:
	-docker container stop container2.cont
	-docker container rm container2.cont
