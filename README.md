# containers

This repository contains Arch Linux Docker base images for my own use, becaues i like using arch as a base.

All images contain a non-root user named `astolfo`, which commands are run on by default. The sudoers file is also configured to allow `astolfo` to run sudo without a password.

All images excluding `minimal` and `minimal-omz` contain NodeJS as this is designed to be a CI/CD base image, and a lot of github steps depend on it.

All images have a `WORK` environment variable (which is also the default working directory) for placing files, ideal for tasks like `actions/checkout` to place files in.<br/>
As of right now, this is `~/work`.
