build: Dockerfile *
	docker build -t container3.img .

start: build
	-docker run -d -p 6666:22 -t --name container3.cont container3.img

stop:
	-docker container stop container3.cont

clean:
	-docker container stop container3.cont
	-docker container rm container3.cont
