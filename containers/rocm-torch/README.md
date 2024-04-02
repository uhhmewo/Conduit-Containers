# rocm-torch

A ROCM-Torch Docker Container.

Run using `docker run -it --device=/dev/kfd --device=/dev/dri --security-opt seccomp=unconfined --group-add video 3xpo/rocm-torch` (ofc adding ur own args as-needed)