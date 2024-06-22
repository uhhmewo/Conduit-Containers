# alpine-wg

An alpine-based wireguard base.

Simply set your FROM to this instead of `alpine`, and add the below to your README:

> If `/etc/wireguard-cfg.d` exists (if you provide it, please make it read only :D), it will start wireguard using a random .conf file in that directory, before running &lt;YOUR PROGRAM&gt;.<br/>
> Additionally, the container might need --priveleged on some systems, which is generally a bad idea.

BTW, you should really consider running a VPN on the host instead of using this image.

If you overwrite `ENTRYPOINT`, make sure the first argument in it is `/bin/wrapwg`.

This image was made for [@3xpo/qbittorrent](https://codeberg.org/Expo/containers/src/branch/master/containers/alpine/qbittorrent), for obvious non-piracy-related reasons.
