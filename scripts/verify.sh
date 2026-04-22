#!/usr/bin/env bash
set -euo pipefail

IMAGE_TAG="${1:-ghcr.io/serene4mr/ros:humble-ros-base-l4t-r35.4.1-fix}"

echo "Verifying apt update in image: ${IMAGE_TAG}"
docker run --rm "${IMAGE_TAG}" bash -lc "apt-get update"
echo "Verification passed."
