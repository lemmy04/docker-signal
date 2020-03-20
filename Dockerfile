# Base docker image
FROM debian:buster

# Label it
LABEL maintainer "Mathias Homann <Mathias.Homann@openSUSE.org>" version=2020-03-20-19.08.15 description="signal messenger in a container"

# Make a user
ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME \
	&& usermod -a -G audio,video user

# install updates and tools for apt
RUN apt-get update
RUN apt-get install -y gpg apt-utils ca-certificates

# add the signal repository
ADD [ "https://updates.signal.org/desktop/apt/keys.asc", "/tmp/key.asc" ]
ADD [ "./signal-xenial.list", "/etc/apt/sources.list.d/signal-xenial.list" ]

# add the key for the repository
RUN apt-key add /tmp/key.asc

# update apt cache
RUN apt-get update

# install signal and one unlisted dependency
RUN apt-get install -y \
	libx11-xcb1 \
	desktop-file-utils \
	signal-desktop

# define the home and user
WORKDIR $HOME
USER user

ENV QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb

# Autorun Signal
CMD ["/usr/bin/signal-desktop"]
