FROM 3xpo/alpine-base

COPY files/wg-setup.sh /bin/wrapwg
RUN apk --no-cache add wireguard-tools openresolv iptables
RUN chmod +x /bin/wrapwg

ENTRYPOINT [ "/bin/wrapwg" ]
