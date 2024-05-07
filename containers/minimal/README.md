# minimal

The base of [`base`](https://codeberg.org/Expo/Containers/src/branch/master/containers/base) (via [`minimal-omz`](https://codeberg.org/Expo/Containers/src/branch/master/containers/minimal-omz)); contains the following packages, alongside everything in `archlinux:latest`:

- `base`
- `base-devel`
- `git`
- `sudo`
- `ssh`
- `zsh`
- `curl`

This image is based on [`3xpo/nothing`](https://codeberg.org/Expo/Containers/src/branch/master/containers/nothing), which itself is `archlinux` with a frequently ran `pacman -Syu`.
