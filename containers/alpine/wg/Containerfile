FROM docker.io/3xpo/alpine-base

USER root
COPY files/wg-setup.sh /bin/wrapwg
RUN apk --no-cache add wireguard-tools openresolv iptables
RUN chmod +x /bin/wrapwg

ENTRYPOINT [ "/bin/wrapwg" ]
