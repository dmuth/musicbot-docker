
# musicbot-docker

This repo contains a Dockerfile for the <a href="https://github.com/Just-Some-Bots/MusicBot">Discord Musicbot</a>.

It can also be found <a href="https://hub.docker.com/r/dmuth1/musicbot/">on Docker Hub</a>.


## Differences Between This Dockerfile and the Dockerfile Shipped With Musicbot

That Dockerfile mounts an existin directly, and requires you to edit configuration files directly.
This Dockerfile allows you to specify configuration values via the enivonrment, which will then
be written directly into the configuration file within the container.

The end result is that this container will have no external side-effects.  All changes made and
packages downloaded will stay within the container and go away when the container is destroyed.

BONUS: The file `config/autoplaylist.txt.IN` will **support comments**.  e.g., you can have lines like this:

```
# Star Trek: The Motion Picture (Score Suite) - YouTube
https://www.youtube.com/watch?v=ULuXSN1Zv1c
# [NEW] Undertale OST - Hopes and Dreams Epic Rock - YouTube
https://www.youtube.com/watch?v=AySnkGYvNIc
# Undertale Remix ðŸŽµ Varien - Heart of the Core (Core Theme) - GameChops - YouTube
https://www.youtube.com/watch?v=NcY0Zyw_oFY
# Waters of Megalovania (ORIGINAL) - YouTube
https://www.youtube.com/watch?v=IQBqSt15Vi0
```

Yeah I like Undertale. <3

Anyway, the `entrypoint.sh` script will script those comments before feeding that file to 
Jukebox, so feel free to add comments to your copy of that file as you see fit.

Got any interesting playlists? <a href="https://github.com/dmuth/musicbot-docker/issues/new">Send them my way!</a>
I may add support for selecting a playlist in a future release. :-)


## Usage


### Via Docker Hub

```
docker pull dmuth1/musicbot
docker run \
	-e TOKEN=token \
	-e OWNER_ID=owner_id \
	-e TEXT_CHANNEL=text_channel_id \
	-e VOICE_CHANNEL=voice_channel_id \
	[-e GRANT_TO_ROLES=role_id ] \
	musicbot
```


### Or... clone this repo and run via docker-compose

```
git clone https://github.com/dmuth/musicbot-docker.git
cd musicbot-docker
cp docker-compose.yml.example docker-compose.yml
vim docker-compose.yml # Edit this file and include the API token, and owner and channel info
docker compose build && docker-compose up
```


## Where to find this In The Wild

The Musicbot is regularly run on <a href="http://discord.gg/anthrocon">Anthrocon's Discord Server</a>.  Feel free to drop on by!


## Contact

I am @dmuth <a href="https://twitter.com/dmuth">on Twitter</a> <a href="https://facebook.com/dmuth">and Facebook</a>.
I can also be reached via email: **dmuth AT dmuth DOT org**.
Or just file a bug here. 


