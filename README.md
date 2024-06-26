## Notice

This repository is mostly atonamous; it guarantees no stability or support. Github Actions handles 99% of repository maintenance, including bi-hourly (CI jobs start at 23 minutes after the hour) CD builds.

Manual intervention will happen either when an issue gets opened on [Codeberg](https://codeberg.org/Expo/Containers/issues), or when I notice an issue.

# containers

This repository contains Arch Linux Docker base images for my own use, becaues i like using arch as a base.

## Structure

[`containers/`](https://codeberg.org/Expo/Containers/src/branch/master/containers)<br/>
`​ |- `[`alpine/`](https://codeberg.org/Expo/Containers/src/branch/master/containers/alpine)<br/>
`​ | ​ ​ This directory contains alpine-based images.`<br/>
`​ | ​ ​ Some of these are general-purpose, some of these are generic.`<br/>
`​ |`<br/>
`​ |- `[`arch/`](https://codeberg.org/Expo/Containers/src/branch/master/containers/arch)<br/>
`​ | ​ ​ This directory contains arch-based non-CI images. Whilst these`<br/>
`​ | ​ ​ images may be used for CI (and are the base for many CI images),`<br/>
`​ | ​ ​ that's not their main purpose.`<br/>
`​ |`<br/>
`​ |- `[`ci/`](https://codeberg.org/Expo/Containers/src/branch/master/containers/ci)<br/>
`​ | ​ ​ This directory contains images specifically designed for CI use.`<br/>
`​ | ​ ​ Excluding 'minimal' and 'minimal-omz', all images here have node`<br/>
`​ | ​ ​ preinstalled, as most actions require it in a CI env.`<br/>

## Users

Images based on `3xpo/minimal` (username `astolfo`) and `3xpo/alpine-base*` (username `lain`) have user accounts.<br/>
By default, these are sudoers. If you don't want your final image to have these as sudoers, you can remove `/etc/sudoers.d/astolfo` and `/etc/sudoers.d/lain` respectively.

`3xpo/alpine-qb` has a user account with username `qb`. It is a sudoer at build time, however the entrypoint `/usr/bin/qb-entrypoint` removes it from the sudoers file at runtime as a security measure.<br/>
This is needed for creating the default configuration and `chown`ing the home directory on launch.

## Multiarch

Non-AMD64/ARM64 builds are entirely untested. ARM64 builds are partially tested, however I assume the upstream distributions do their own due-diligence. Any bugs not related to the contents of this repository (the containerfiles are relatively simple, you can likely relatively easily figure out if it's a bug related to it) are likely to be upstream distro issues, or related to distros' upstreams.<br/>
If you find a bug on a non-AMD64 system that you can't reproduce on the upstream package, please do report it here! Just because they're untested doesn't mean I don't want them to work :)
