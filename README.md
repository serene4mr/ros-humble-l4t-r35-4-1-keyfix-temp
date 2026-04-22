# ros-humble-l4t-r35-4-1-keyfix-temp

Temporary image repo that patches ROS 2 apt key/repo configuration on top of:

- `dustynv/ros:humble-ros-base-l4t-r35.4.1`

This avoids `EXPKEYSIG F42ED6FBAB17C654` failures during `apt-get update`.

## Build

```bash
docker build -t ghcr.io/serene4mr/ros:humble-ros-base-l4t-r35.4.1-fix .
```

## Verify

```bash
bash scripts/verify.sh ghcr.io/serene4mr/ros:humble-ros-base-l4t-r35.4.1-fix
```

## Use downstream

Set your downstream base image to:

- `ghcr.io/serene4mr/ros:humble-ros-base-l4t-r35.4.1-fix`

## Cleanup plan

This is a temporary bridge image. Remove this repo and retire the tag once upstream base images are known-good again or your stack migrates to a maintained base.