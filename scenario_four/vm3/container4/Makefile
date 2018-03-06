build: Dockerfile *
	docker build -t container4.img .

start: build
	-docker run -d -p 7777:22 -t --name container4.cont container4.img

stop:
	-docker container stop container4.cont

clean:
	-docker container stop container4.cont
	-docker container rm container4.cont
