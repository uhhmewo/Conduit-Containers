#!/bin/bash
set -eax

if ! [[ -f /etc/caddy/Caddyfile ]]; then
  push() {
    echo "$1" >> /etc/caddy/Caddyfile
  }
  if [[ "$CLIENT_LISTEN_ON" == "" ]] && [[ "$SERVER_LISTEN_ON" == "" ]] && [[ "$LISTEN_ON" != "" ]]; then
    CLIENT_LISTEN_ON="$LISTEN_ON"
    SERVER_LISTEN_ON="$LISTEN_ON"
  fi;
  if [[ "$CLIENT_LISTEN_ON" == "" ]] && [[ "$CLIENT_LIVES_AT" != "" ]]; then
    echo "Warn: CLIENT_LISTEN_ON is blank. We don't know where to listen on. Please set CLIENT_LISTEN_ON to a value, or specify your own Caddyfile." 1>&2;
    echo "      Assuming you want us to listen on *:80 in the container." 1>&2;
    CLIENT_LISTEN_ON="http://"
  fi;
  if [[ "$SERVER_LISTEN_ON" == "" ]] && [[ "$SERVER_LIVES_AT" != "" ]]; then
    echo "Warn: SERVER_LISTEN_ON is blank. We don't know where to listen on. Please set SERVER_LISTEN_ON to a value, or specify your own Caddyfile." 1>&2;
    echo "      Assuming you want us to listen on *:80 in the container." 1>&2;
    SERVER_LISTEN_ON="http://"
  fi;

  if [[ "$CLIENT_LISTEN_ON" == "$SERVER_LISTEN_ON" ]] && [[ "$CLIENT_LIVES_AT" != "" ]] && [[ "$SERVER_LIVES_AT" != "" ]]; then
    # mixed client & server
    push "$CLIENT_LISTEN_ON"' {'
    push '  reverse_proxy /_matrix/* '"$SERVER_LIVES_AT"
    push '  reverse_proxy /.well-known/matrix/client '"$CLIENT_LIVES_AT"
    push '  reverse_proxy /.well-known/matrix/server '"$SERVER_LIVES_AT"
    push '  reverse_proxy '"$CLIENT_LIVES_AT"
    push '}'
  else
    # either client, or server, or both but separate domains
    if [[ "$CLIENT_LIVES_AT" != "" ]]; then
      push "$CLIENT_LISTEN_ON"' {'
      if [[ "$CLIENT_NO_HOST_HEADER" == "true" ]]; then
        push '  reverse_proxy '"$CLIENT_LIVES_AT"
      else
        push '  reverse_proxy '"$CLIENT_LIVES_AT"' {'
        push '    header_up Host {upstream_hostport}'
        push '  }'
      fi;
      push '}'
    fi;
    if [[ "$SERVER_LIVES_AT" != "" ]]; then
      push "$SERVER_LISTEN_ON"' {'
      if [[ "$SERVER_NO_HOST_HEADER" == "true" ]]; then
        push '  reverse_proxy '"$SERVER_LIVES_AT"
      else
        push '  reverse_proxy '"$SERVER_LIVES_AT"' {'
        push '    header_up Host {upstream_hostport}'
        push '  }'
      fi;
      push '}'
    fi;
  fi;
fi;
/usr/sbin/caddy validate --config /etc/caddy/Caddyfile
/usr/sbin/caddy run --environ --config /etc/caddy/Caddyfile
