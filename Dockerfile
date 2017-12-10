#
# Based on a Dockerfile I first found at https://github.com/Omar007/Docker-DiscordMusicBot/blob/master/Dockerfile,
# I optmized it quite a bit.
#
# Build:
#	docker build --tag musicbot .
#
# Run:
# 	docker run -e TOKEN=token -e OWNER_ID=owner_id -e TEXT_CHANNEL=text_channel_id -e VOICE_CHANNEL=voice_channel_id [-e GRANT_TO_ROLES=role_id ] musicbot
#
# Debugging:
# 	docker run -it musicbot bash
#

#
# Building this Docker image on Ubuntu 16.04: 905 MB
# Building this image on Alpine with separate RUN layers: 384 MB
# Building this image on Alpine with a single layer: 289 MB
#


FROM alpine:latest

LABEL maintainer="dmuth@dmuth.org"

#
# According to https://github.com/laradock/laradock/issues/1164#issuecomment-343484685, 
# I should stop seeing "empty continuation line" warnings in Docker 17.10.
#

RUN apk add --update wget unzip libcurl \
	#
	# Musicbot dependencies
	#
	&& apk add python3 python3-dev ffmpeg opus-dev \
	#
	# Download and install pip
	#
	&& wget https://bootstrap.pypa.io/get-pip.py && python3 ./get-pip.py \
	&& python3 ./get-pip.py \
	#
	# Compilation for the pip install command
	#
	&& apk add gcc make libc-dev binutils libffi-dev \
	#
	# Git
	#
	&& apk add git \
	#
	# Clone the master branch of the codebase
	#
	&& git clone -b master --single-branch https://github.com/Just-Some-Bots/MusicBot.git /var/Musicbot \
	#
	# Install modules in Python
	#
	# According to https://github.com/pysam-developers/pysam/issues/184, this: 
	#
	#	Running setup.py bdist_wheel for PyNaCl
	#
	# ...can take awhile! Took like 2 minutes on my iMac.
	#
	&& python3 -m pip install -U -r /var/Musicbot/requirements.txt \
	#
	# For our entrypoint script
	#
	&& apk add bash \
	#
	# Remove packages no longer used
	#
	&& apk del wget gcc make git \
	&& rm -rf /var/lib/apt/lists/*

COPY config/* /var/Musicbot/config/

COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]

