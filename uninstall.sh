#!/bin/bash

systemctl stop feed1090
systemctl disable feed1090

rm -f /lib/systemd/system/feed1090.service
