build: Dockerfile *
	docker build -t container1.img .

start: build
	-docker run -d -p 4444:22 -t --name container1.cont container1.img

stop:
	-docker container stop container1.cont

clean:
	-docker container stop container1.cont
	-docker container rm container1.cont
