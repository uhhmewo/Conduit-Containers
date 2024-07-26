#!/bin/bash
set -eax

jqInPlace() {
  # sed -i but for jq
  jq "$1" "$2" > /tmp/.jq-i
  mv /tmp/.jq-i $2
}

if ! [[ -f /etc/caddy/Caddyfile ]]; then
  push() {
    echo "$1" >> /etc/caddy/Caddyfile
  }
  if [[ "$LISTEN_ON" == "" ]]; then
    echo "Warn: LISTEN_ON is blank. We don't know where to listen on. Please set LISTEN_ON to a value, or specify your own Caddyfile." 1>&2;
    echo "      Assuming you want us to listen on *:80 in the container." 1>&2;
    LISTEN_ON="http://"
  fi;
  push "$LISTEN_ON"' {'
  if [[ "$ALLOW_FRAMING" != "true" ]]; then
    push '  header * X-Frame-Options SAMEORIGIN'
    push '  header * Content-Security-Policy "frame-ancestors 'self'"'
  fi;
  if [[ "$DISABLE_XSS_PROTECTION" != "true" ]]; then
    push '  header * X-XSS-Protection "1; mode=block;"'
  fi;
  if [[ "$DISABLE_NOSNIFF" != "true" ]]; then
    push '  header * X-Content-Type-Options nosniff'
  fi;
  push ''
  push '  header /.well-known/matrix/* Content-Type application/json'
  push '  header /.well-known/matrix/* Access-Control-Allow-Origin *'
  if [[ "$FEDERATION_TARGET" != "" ]]; then
    if [[ -f /var/www/html/.well-known/matrix/server ]]; then
      echo "/var/www/html/.well-known/matrix/server exists, please unset FEDERATION_TARGET." 1>&2
      exit 1
    fi;
    # For a custom value, keep FEDERATION_TARGET blank and shove your own file in /var/www/html/.well-known/matrix/server - use $OCI_HOST volumes for this
    push '  respond /.well-known/matrix/server `{"m.server": "'"$FEDERATION_TARGET"'"}`'
  fi;
  if [[ "$HOMESERVER_BASE_URL" != "" ]]; then
    if [[ -f /var/www/html/.well-known/matrix/client ]]; then
      echo "/var/www/html/.well-known/matrix/client exists, please unset HOMESERVER_BASE_URL." 1>&2
      exit 1
    fi;
    # For a custom value, keep HOMESERVER_BASE_URL blank and shove your own file in /var/www/html/.well-known/matrix/client - use $OCI_HOST volumes for this
    # https://matrix-org.github.io/matrix-authentication-service/setup/well-known.html
    push '  respond /.well-known/matrix/client `{"m.homeserver":{"base_url":"'"$HOMESERVER_BASE_URL"'"}}`'
  fi;
  if [[ "$PROXY_MATRIX_TRAFFIC_TO" != "" ]] && [[ "$REDIRECT_MATRIX_TRAFFIC_TO" != "" ]]; then
    echo "Both PROXY_MATRIX_TRAFFIC_TO and REDIRECT_MATRIX_TRAFFIC_TO are non-blank values. Pick one." 1>&2;
    exit 1;
  elif [[ "$PROXY_MATRIX_TRAFFIC_TO" != "" ]]; then
    push '  reverse_proxy /_matrix/* '"$PROXY_MATRIX_TRAFFIC_TO"
    if [[ "$USE_PERMANENT_MATRIX_REDIRECT" != "" ]]; then
      echo "Warning: USE_PERMANENT_MATRIX_REDIRECT cannot be used with proxying traffic. Ignoring." 1>&2
    fi;
  elif [[ "$REDIRECT_MATRIX_TRAFFIC_TO" != "" ]]; then
    LINE="  redir /_matrix/* ${REDIRECT_MATRIX_TRAFFIC_TO}{uri}"
    if [[ "$USE_PERMANENT_MATRIX_REDIRECT" == "true" ]]; then
      LINE="$LINE"' permanent'
    else
      LINE="$LINE"' temporary'
    fi;
    push "$LINE"
  fi;
  push ''
  push '  root /* /var/www/html'
  push '  file_server'
  push '}'
fi;
if [[ "$DEFAULT_CLIENT_HOMESERVER" != "" ]]; then
  # Set fluffychat default homeserver
  if [[ -f /var/www/html/fluffychat/config.json ]]; then
    jqInPlace ".default_homeserver=\"$DEFAULT_CLIENT_HOMESERVER\"" /var/www/html/fluffychat/config.json
  fi;

  # Set cinny default homeserver
  if [[ -f /var/www/html/cinny/config.json ]]; then
    jqInPlace ".homeserverList |= . + [$(jq '.homeserverList[0]' /var/www/html/cinny/config.json)]" /var/www/html/cinny/config.json
    jqInPlace ".homeserverList[0]=\"$DEFAULT_CLIENT_HOMESERVER\"" /var/www/html/cinny/config.json
    jqInPlace '.defaultHomeserver=0' /var/www/html/cinny/config.json
  fi;

  # Set element default homeserver
  if [[ -f /var/www/html/element/config.json ]]; then
    jqInPlace '.default_server_config["m.homeserver"].server_name="'"$DEFAULT_CLIENT_HOMESERVER"'"' /var/www/html/element/config.json
    jqInPlace ".room_directory.servers |= . + [$(jq '.room_directory.servers[0]' /var/www/html/cinny/config.json)]" /var/www/html/cinny/config.json
    jqInPlace '.room_directory.servers[0]="'"$DEFAULT_CLIENT_HOMESERVER"'"' /var/www/html/cinny/config.json
  fi;
fi;

/usr/sbin/caddy validate --config /etc/caddy/Caddyfile || EXIT_CODE=$? sh -c 'echo "Caddyfile:" && cat /etc/caddy/Caddyfile && exit $EXIT_CODE'
/usr/sbin/caddy run --environ --config /etc/caddy/Caddyfile
