#!/bin/ash

apk add docker docker-compose
rc-update add docker boot
rc-service docker restart
