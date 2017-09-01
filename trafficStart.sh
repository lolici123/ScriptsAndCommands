#!/bin/bash

sudo iptables -D INPUT ! -i lo -p tcp --destination-port 80 -j DROP
