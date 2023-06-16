#!/usr/bin/env bash
set -x
function check_dependencies() {
  for pkg in curl jq; do
    if ! type -p "${pkg}" &>/dev/null; then
      echo "You must install '${pkg}' first to proceed!"
      EXIT_ON_LOOP_END="True"
    fi
  done
  if [[ "${EXIT_ON_LOOP_END}" == "True" ]]; then
    return 1
  fi
}
function get_latest_github_release_version() {
  curl -s "https://api.github.com/repos/${GH_ORG}/${GH_REPO}/releases/latest" | jq -r '.tag_name'
}
function install_shellformat {
  local SHELLFORMAT_VERSION="latest"
  local GH_ORG="mvdan"
  local GH_REPO="sh"
  local ARCHITECTURE
  local KERNEL_NAME
  local USER_NAME
  USER_NAME=$(id -un)
  ARCHITECTURE=$(uname -m)
  KERNEL_NAME=$(uname -s)

  if [[ "${SHELLFORMAT_VERSION}" = "latest" ]]; then
    SHELLFORMAT_VERSION="$(get_latest_github_release_version)"
  fi
  case "${ARCHITECTURE,,}" in
  aarch64 | arm64)
    SHELLFORMAT_ARCHITECTURE="arm64"
    ;;
  x86_64)
    SHELLFORMAT_ARCHITECTURE="amd64"
    ;;
  *)
    echo "Unknown architecture: ${ARCHITECTURE}"
    ;;
  esac
  DOWNLOAD_FILENAME="shfmt_${SHELLFORMAT_VERSION,,}_${KERNEL_NAME,,}_${SHELLFORMAT_ARCHITECTURE,,}"
  DOWNLOAD_URL="https://github.com/${GH_ORG}/${GH_REPO}/releases/download/${SHELLFORMAT_VERSION}/${DOWNLOAD_FILENAME}"
  if curl -sL "${DOWNLOAD_URL}" -o "/home/${USER_NAME}/.local/bin/shfmt"; then
    chmod +x "/home/${USER_NAME}/.local/bin/shfmt"
    if shfmt --version &>/dev/null; then
      echo "Installed '${DOWNLOAD_FILENAME}' to '/home/${USER_NAME}/.local/bin/shfmt'"
    fi
  fi
}
function main() {
  if shfmt --version &>/dev/null; then
    exit 0
  fi
  echo "Installing 'shellformat'..."
  check_dependencies
  install_shellformat
}
main
