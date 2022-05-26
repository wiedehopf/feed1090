#!/bin/bash

set -e
trap 'echo "[ERROR] Error in line $LINENO when executing: $BASH_COMMAND"' ERR
renice 10 $$

IPATH=/usr/local/share/feed1090

function aptInstall() {
    if ! apt install -y --no-install-recommends --no-install-suggests "$@"; then
        apt update
        apt install -y --no-install-recommends --no-install-suggests "$@"
    fi
}

if ! command -v wget &>/dev/null; then
    aptInstall wget
fi

if [[ -z "$1" ]] || [[ "$1" != "test" ]]; then
	cd /tmp
	if ! wget -q -O master.zip https://github.com/wiedehopf/feed1090/archive/master.zip || ! unzip -q -o master.zip
	then
		echo "Unable to download files, exiting!"
		exit 1
	fi
	cd feed1090-master
elif [[ "$1" == "test" ]]; then
    tmpdir=/tmp/feed1090-test
    mkdir -p $tmpdir
    cp -r ./* $tmpdir
    cd $tmpdir
fi

# compile readsb
bash readsb-nopackage.sh "$IPATH/bin"


if ! id -u feed1090 &>/dev/null
then
    adduser --system --home $IPATH --no-create-home --quiet feed1090
fi

cp -n feed1090.default /etc/default/feed1090
cp feed1090.service /lib/systemd/system

systemctl enable feed1090
systemctl restart feed1090

echo --------------
echo "All done, don't forget to configure (sudo nano /etc/default/feed1090)"
echo "After you are done with configuration don't forget"
echo "to apply the new settings (sudo systemctl restart feed1090)"
echo --------------


cd /tmp
rm -rf /tmp/feed1090-master /tmp/feed1090-test
