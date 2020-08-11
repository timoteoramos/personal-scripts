#!/bin/bash

dnf install -y podman{,-compose}
systemctl enable podman
