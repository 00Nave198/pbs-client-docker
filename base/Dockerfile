FROM debian:12-slim

# Install wget
RUN apt-get update \
	&& apt-get install wget -y \
	&& apt-get clean 

# Enable pbs repo, install pbs client
RUN wget http://download.proxmox.com/debian/proxmox-release-bookworm.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg
RUN echo "deb http://download.proxmox.com/debian/pbs-client bookworm main" > /etc/apt/sources.list.d/pbs-client.list
RUN apt-get update \
	&& apt-get install proxmox-backup-client -y \
	&& apt-get clean 

LABEL maintainer="Evan Masters 00evanmasters@gmail.com"
ENTRYPOINT ["proxmox-backup-client"]
CMD ["help"]
