#!/bin/bash
#
# Our main entrypoint to run the Musicbot
#

# Errors are fatal
set -e

# Debugging
#set -x

cd /var/Musicbot/

pushd config/ 2>/dev/null

cat options.ini.IN | sed \
	-e "s/%TOKEN%/$TOKEN/" \
	-e "s/%OWNER_ID%/$OWNER_ID/" \
	-e "s/%TEXT_CHANNEL%/$TEXT_CHANNEL/" \
	-e "s/%VOICE_CHANNEL%/$VOICE_CHANNEL/" \
	> options.ini

if test "$GRANT_TO_ROLES"
then
	cat permissions.ini.IN |sed -e "s/;%GRANT_TO_ROLES%/GrantToRoles = $GRANT_TO_ROLES/" > permissions.ini

else
	echo "# "
	echo "# Variable GRANT_TO_ROLES not specified, not parsing file but just copying it over."
	echo "# "
	cp permissions.ini.IN permissions.ini

fi

popd 2>/dev/null

/usr/bin/python3 /var/Musicbot/run.py

