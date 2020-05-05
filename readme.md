# Ubuntu 20.04 server network install environment by docker-compose

This is the docker-compose environment for pxe boot.

# Motivation

Set up ubuntu server is mess.

To make boot environment, USB device or Writable CD was required, Unfortunately I temporarily ran out of both.

So I created network boot environment by docker-compose.

# Reuirement 

The pxeboot requires two protocols which are DHCP and tftp.

| service | port | protocol |
| ---------- | ---------- | ---------- |
| DHCP       | 67         | UDP        |
| TFTP       | 69         | UDP        |

Also you need the http path holds ISO file.
The docker-compose contains nginx as holding the iso file.

| service | port | protocol |
| ---------- | ---------- | ---------- |
| HTTP       | 80         | TCP        |

Make sure firewall allowed and another process does not occupy the ports at the server.

# Build

> docker build . -t pxeboot-ubuntu-20.04

# Run

You have to probvide .env file like the below.

To be simplify, I provide a script which determine current ip and phisical device.

> sh create_env.sh > .env

The script creates like the below env file used by dnsmasq.

You can change the environmtnt variable you want to.

.env
```
#interface
interface=eth0,lo
#ip range
iprange_low=192.168.0.201
iprange_high=192.168.0.245
#server ip
server_ip=192.168.0.1

#http(actual iso path)
focal=/home/axt/Downloads/focal-live-server-amd64.iso
```

You have to download focal-live-server iso image from ubuntu (mirror) server.

**And mount it to /mnt/cd which uses by docker-compose**.

> sudo mount <download path> /mnt/cd

**And be determined where is the path as environment variable 'focal' by the .env file like the above**.

That is prerequired.

Then, server and target client is connected locally.
(Crossover cable or HUB not connected others)

At server,

> docker-compose up -d

At target client which you want to install ubuntu server, 

boot via pxe.

# appendix

## How to get iso

Daily live iso is [here](http://cdimage.ubuntu.com/ubuntu-server/daily-live/current/)

## See

Instruction how to install via netboot is the below.

https://discourse.ubuntu.com/t/netbooting-the-live-server-installer/14510