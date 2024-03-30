FROM ghcr.io/00nave198/pbs-client-docker:latest

# Install cron
RUN apt-get update \
	&& apt-get install cron -y \
	&& apt-get clean 

COPY entrypoint.sh /entrypoint.sh

LABEL maintainer="Evan Masters 00evanmasters@gmail.com"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["cron", "-f", "-l", "2"]
