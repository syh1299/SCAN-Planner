#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IMAGE="${SCAN_PLANNER_IMAGE:-osrf/ros:noetic-desktop-full}"
xhost +local:docker >/dev/null 2>&1 || true

docker run --rm -it \
  --network host \
  -e DISPLAY="${DISPLAY:-}" \
  -e QT_X11_NO_MITSHM=1 \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v "${ROOT}:/ws" \
  -w /ws \
  "${IMAGE}" \
  bash -lc '
    source /opt/ros/noetic/setup.bash
    if [ -f /ws/devel/setup.bash ]; then source /ws/devel/setup.bash; fi
    echo "SCAN-Planner container ready."
    echo "RViz:  roslaunch scan_planner rviz.launch"
    echo "Algo:  roslaunch scan_planner run.launch"
    exec bash
  '
