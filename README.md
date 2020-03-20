# docker-signal
Running signal in a docker container

to run the container:

```
docker run --rm -it \
	--name Signal \
	--hostname=$(hostname) \
	--device /dev/snd \
	-e DISPLAY=unix$DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v ~/.Xauthority:/home/user/.Xauthority \
	-v /etc/localtime:/etc/localtime:ro \
	-v ~/.docker/.SignalData:/home/user/.config/Signal \
	lemmy04/signal
```

to run the container when your home is on nfs you have to do it this way:

```
docker run --rm -it --user root \
	--name Signal \
	--hostname=$(hostname) \
	--device /dev/snd \
	-e DISPLAY=unix$DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v ~/.Xauthority:/home/user/.Xauthority \
	-v /etc/localtime:/etc/localtime:ro \
	-v ~/.docker/.SignalData:/home/user/.config/Signal \
	lemmy04/signal /usr/bin/signal-desktop --no-sandbox
```

