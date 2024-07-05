#!/bin/bash
set -eax
chown -R lain "$CONDUIT_DATABASE_PATH"
sudo -E -u lain "/srv/conduit/conduit"