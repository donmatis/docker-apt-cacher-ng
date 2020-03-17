# Ubuntu APT Cacher
# MAINTAINER Stamatis Michas <stamatis.michas@comlaude.com>
FROM ubuntu:18.04

# Set env variables
ENV APT_CACHER_NG_CACHE_DIR=/var/cache/apt-cacher-ng \
    APT_CACHER_NG_LOG_DIR=/var/log/apt-cacher-ng \
    APT_CACHER_NG_USER=apt-cacher-ng \
    DEBIAN_FRONTEND=noninteractive

# Update system and install packages
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    apt-cacher-ng ca-certificates wget 

# Fix apt-cacher configuration
RUN sed 's/# ForeGround: 0/ForeGround: 1/' -i /etc/apt-cacher-ng/acng.conf && \
    sed 's/# PassThroughPattern: .* # this would allow.*/PassThroughPattern: .*/' -i /etc/apt-cacher-ng/acng.conf

# Set the entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 755 /usr/local/bin/entrypoint.sh

EXPOSE 3142/tcp

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
        CMD wget -q -t1 -o /dev/null  http://localhost:3142/acng-report.html || exit 1

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

CMD ["/usr/sbin/apt-cacher-ng"]