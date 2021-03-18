FROM ghost:4.0.1

COPY scripts/run.sh /var/lib/ghost/run.sh
RUN \
    apt update && \
    apt -y install wget && \
    chmod a+x  /var/lib/ghost/run.sh && \
    mkdir /var/lib/ghost/keys && \
    #   Clean Up Image
    apt clean && \
    rm -rf /var/lib/apt/lists/*


VOLUME /var/lib/ghost/keys/
EXPOSE 2368
CMD ["/var/lib/ghost/run.sh"]
