FROM andyshinn/dnsmasq

LABEL maintainer: "axt_star@hotmail.com"

#get netboot.tar.gz and extract to tftp root dir
WORKDIR /srv/tftp/
RUN mkdir -p /srv/tftp/ && wget http://archive.ubuntu.com/ubuntu/dists/bionic-updates/main/installer-amd64/current/images/netboot/netboot.tar.gz \
&& tar xvfz netboot.tar.gz

## replace default as own ip
COPY conf/pxelinux/default.template /srv/tftp/pxelinux.cfg/default.template

## pxe server settings
COPY conf/dnsmasq/pxe.conf.template /etc/dnsmasq.d/pxe.conf.template

RUN echo "user=root" >> /etc/dnsmasq.conf
RUN echo "log-facility=-" >> /etc/dnsmasq.conf

WORKDIR /root
COPY src/runscript.sh .
RUN chmod +x runscript.sh
ENTRYPOINT ["/root/runscript.sh"]