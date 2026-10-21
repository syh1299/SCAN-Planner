#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IMAGE="${SCAN_PLANNER_IMAGE:-osrf/ros:noetic-desktop-full}"

docker run --rm \
  -v "${ROOT}:/ws" \
  -w /ws \
  "${IMAGE}" \
  bash -lc '
    set -e
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends libarmadillo-dev
    source /opt/ros/noetic/setup.bash
    catkin_make -DCMAKE_BUILD_TYPE=Release
  '
