
# musicbot-docker

This repo contains a Dockerfile for the <a href="https://github.com/Just-Some-Bots/MusicBot">Discord Musicbot</a>.


## Differences Between This Dockerfile and the Dockerfile Shipped With Musicbot

That Dockerfile mounts an existin directly, and requires you to edit configuration files directly.
This Dockerfile allows you to specify configuration values via the enivonrment, which will then
be written directly into the configuration file within the container.

The end result is that this container will have no external side-effects.  All changes made and
packages downloaded will stay within the container and go away when the container is destroyed.

## Usage

### Via Docker Hub

`docker pull dmuth1/musicbot`
`docker run -e TOKEN=token -e OWNER_ID=owner_id -e TEXT_CHANNEL=text_channel_id -e VOICE_CHANNEL=voice_channel_id [-e GRANT_TO_ROLES=role_id ] musicbot`

### Or... clone this repo and run via docker-compose

`git clone https://github.com/dmuth/musicbot-docker.git`
`cd musicbot-docker`
`cp docker-compose.yml.example docker-compose.yml`
`vim docker-compose.yml # Edit this file and include the API token, and owner and channel info`
`docker compose build && docker-compose up`




