# containers

This repository contains Arch Linux Docker base images for my own use, becaues i like using arch as a base.

## Users

All images contain a non-root user named `astolfo`, which commands are run on by default. The sudoers file is also configured to allow `astolfo` to run sudo without a password.

## NodeJS

All images excluding `minimal` and `minimal-omz` contain NodeJS as this is designed to be a CI/CD base image, and a lot of github steps depend on it.

## Directory Structure

All images have a `WORK` environment variable (which is also the default working directory) for placing files, ideal for tasks like `actions/checkout` to place files in.<br/>
As of right now, this is `~/work`.

## Update Frequency

Usually running `pacman -Syu` is needed with `archlinux`'s official container. This container, however, updates every hour on Docker Hub, meaning we'll at most be an hour out of date - which is something a lot of package mirrors can't even promise.

> Note: You may still need to rerun `pacman -Syu` if your CI system caches the image, as it may not pull the latest version.<br/>
> Note 2: This excludes the rocm-torch package, as the CI builder doesnt have the disk space to build it. As a hotfix, it uses [ONBUILD](https://docs.docker.com/reference/dockerfile/#onbuild) to update when you build an image based on it.
