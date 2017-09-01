#!/bin/bash

sudo iptables -A INPUT ! -i lo -p tcp --destination-port 80 -j DROP
