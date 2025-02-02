FROM ghost:5.109.0

COPY scripts/run.sh /var/lib/ghost/run.sh
RUN \
    apt update && \
    apt -y install wget && \
    chmod a+x  /var/lib/ghost/run.sh && \
    mkdir -p /tmp/gcs ${GHOST_CONTENT}/adapters/storage/gcs && \
    mkdir /var/lib/ghost/keys && \
#    npm install -g npm@7.11.0 && \
    #   Clean Up Image
    apt clean && \
    rm -rf /var/lib/apt/lists/*


VOLUME /var/lib/ghost/keys/
EXPOSE 2368
CMD ["/var/lib/ghost/run.sh"]
