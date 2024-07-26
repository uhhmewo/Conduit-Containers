#!/bin/sh

chown -R lain /var/lib/matrix-conduit
exec sudo -u lain /srv/conduit/conduit
