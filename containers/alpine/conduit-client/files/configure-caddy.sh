#!/bin/bash
set -eax
if [[ "$SERVER_ADDR" == "" ]]; then
  SERVER_ADDR="${CONDUIT_SERVER_NAME}"
fi;
if [[ "$SERVER_ADDR" == "" ]]; then
  echo "FATAL: Must specify the SERVER_ADDR environment variable to the domain you're hosting this on." 1>&2
  exit 1
fi;
sed -i "s|example.com|${SERVER_ADDR}|g" /etc/caddy/Caddyfile
sed -i "s|example.org|${CONDUIT_SERVER_NAME}|g" /etc/caddy/Caddyfile
if [[ "$SERVER_ADDR" == "localhost" ]]; then
  sed -i "s|https://localhost|http://localhost|g" /etc/caddy/Caddyfile
  sed -i "s|localhost {|http://localhost {|g" /etc/caddy/Caddyfile
fi;
sed -i "s|https://http://|http://|g" /etc/caddy/Caddyfile
sed -i "s|https://https://|https://|g" /etc/caddy/Caddyfile
sed -i "s|http://http://|http://|g" /etc/caddy/Caddyfile
sed -i "s|http://https://|https://|g" /etc/caddy/Caddyfile
tmpfn() {
  if [[ -f "/var/www/html/cinny/config.json" ]] && [[ "$(jq -r .isDefaultConfig /var/www/html/cinny/config.json)" == "true" ]]; then
    jq '.homeserverList |= . + ['"$(jq .homeserverList[0] /var/www/html/cinny/config.json)"']' /var/www/html/cinny/config.json > /tmp/a.json
    jq '.homeserverList[0]="'"$CONDUIT_SERVER_NAME"'"' /tmp/a.json > /var/www/html/cinny/config.json
    jq '.defaultHomeserver=0' /var/www/html/cinny/config.json > /tmp/a.json
    jq . /tmp/a.json > /var/www/html/cinny/config.json
    rm /tmp/a.json
  fi;
  export PUBLIC_BASE='http'"$((grep localhost <<< "$CONDUIT_SERVER_NAME" > /dev/null) && echo -n '' || echo -n 's')"'://'"$CONDUIT_SERVER_NAME"
  if [[ -d "/var/www/html/fluffychat" ]] && ! [[ -f "/var/www/html/fluffychat/config.json" ]]; then
    echo '{
  "default_homeserver": "'"$CONDUIT_SERVER_NAME"'",
  "web_base_url": "'"$PUBLIC_BASE"'/fluffychat"
}' > /var/www/html/fluffychat/config.json
    if grep 'http://' <<< "$PUBLIC_BASE" >/dev/null; then
      jq '.default_homeserver="'"$PUBLIC_BASE"'"' /var/www/html/fluffychat/config.json > /tmp/a.json
      mv /tmp/a.json /var/www/html/fluffychat/config.json
    fi
  fi;
  if [[ -d "/var/www/html/element" ]] && ! [[ -f "/var/www/html/element/config.json" ]]; then
    echo '{
  "default_server_config": {
    "m.homeserver": {
      "base_url": "'"$PUBLIC_BASE"'",
      "server_name": "'"$CONDUIT_SERVER_NAME"'"
    },
    "m.identity_server": {
      "base_url": "https://vector.im"
    }
  },
  "disable_custom_urls": false,
  "disable_guests": false,
  "disable_login_language_selector": false,
  "disable_3pid_login": false,
  "brand": "Element",
  "integrations_ui_url": "https://scalar.vector.im/",
  "integrations_rest_url": "https://scalar.vector.im/api",
  "integrations_widgets_urls": [
    "https://scalar.vector.im/_matrix/integrations/v1",
    "https://scalar.vector.im/api",
    "https://scalar-staging.vector.im/_matrix/integrations/v1",
    "https://scalar-staging.vector.im/api",
    "https://scalar-staging.riot.im/scalar/api"
  ],
  "default_country_code": "GB",
  "show_labs_settings": true,
  "features": {},
  "default_federate": true,
  "default_theme": "dark",
  "room_directory": {
    "servers": [
      "'"$CONDUIT_SERVER_NAME"'",
      "matrix.org",
      "envs.net",
      "monero.social",
      "mozilla.org",
      "xmr.se"
    ]
  },
  "enable_presence_by_hs_url": {
    "https://matrix.org": false,
    "https://matrix-client.matrix.org": false
  },
  "setting_defaults": {
    "breadcrumbs": true
  },
  "jitsi": {
    "preferred_domain": "meet.element.io"
  },
  "element_call": {
    "url": "https://call.element.io",
    "participant_limit": 8,
    "brand": "Element Call"
  },
  "map_style_url": "https://api.maptiler.com/maps/streets/style.json?key=fU3vlMsMn4Jb6dnEIFsx"
}
' > /var/www/html/element/config.json
  fi;
}
tmpfn || true
/usr/sbin/caddy validate --config /etc/caddy/Caddyfile
/usr/sbin/caddy run --environ --config /etc/caddy/Caddyfile
