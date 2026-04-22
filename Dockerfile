FROM dustynv/ros:humble-ros-base-l4t-r35.4.1

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN rm -f /etc/apt/sources.list.d/ros*.list /etc/apt/sources.list.d/*ros* || true \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg2 \
    lsb-release \
    python3-pip \
    python3-venv \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    python3.8-venv \
 && curl -fsSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
    | gpg --batch --yes --dearmor -o /usr/share/keyrings/ros-archive-keyring.gpg \
 && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo ${UBUNTU_CODENAME}) main" \
    > /etc/apt/sources.list.d/ros2.list \
 && apt-get update \
 && if apt-cache show ros-humble-diagnostic-updater >/dev/null 2>&1; then \
      DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ros-humble-diagnostic-updater; \
    else \
      echo "INFO: ros-humble-diagnostic-updater not available in current ROS apt repo; skipping."; \
    fi \
 && if ! colcon build --help 2>/dev/null | grep -q -- "--mixin"; then \
      python3 -m pip install --no-cache-dir colcon-mixin; \
    fi \
 && if ! colcon mixin list 2>/dev/null | grep -q '^default'; then \
      colcon mixin add default https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml; \
    fi \
 && colcon mixin update default \
 && if [ -f /opt/ros/humble/install/setup.bash ] && [ ! -f /opt/ros/humble/setup.bash ]; then \
      printf '%s\n' '#!/usr/bin/env bash' 'source /opt/ros/humble/install/setup.bash "$@"' > /opt/ros/humble/setup.bash; \
      chmod +x /opt/ros/humble/setup.bash; \
    fi \
 && if [ -f /opt/ros/humble/install/local_setup.bash ] && [ ! -f /opt/ros/humble/local_setup.bash ]; then \
      printf '%s\n' '#!/usr/bin/env bash' 'source /opt/ros/humble/install/local_setup.bash "$@"' > /opt/ros/humble/local_setup.bash; \
      chmod +x /opt/ros/humble/local_setup.bash; \
    fi \
 && rm -rf /var/lib/apt/lists/*
