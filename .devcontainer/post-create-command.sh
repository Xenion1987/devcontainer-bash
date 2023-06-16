#!/usr/bin/env bash

function install_pip_requirements() {
  pip3 -qq install --upgrade --user -r .devcontainer/requirements.txt
}
function pre_commit() {
  pre-commit install
  pre-commit autoupdate
}
function create_code_workspace() {
  HEAD="{ \"folders\": ["
  TAIL="],\"settings\": {} }"
  WORKSPACE_LOCATIONS=(/home/vscode/workspace)

  echo -e "${HEAD}" >"${HOME}/dev.code-workspace"

  for WORKSPACE_LOCATION in "${WORKSPACE_LOCATIONS[@]}"; do
    PROJECTS=$(ls -1 "${WORKSPACE_LOCATION}")
    for PROJECT in ${PROJECTS}; do

      MAIN="  { \"path\": \"${WORKSPACE_LOCATION}/${PROJECT}\" },"
      echo -e "${MAIN}" >>"${HOME}/dev.code-workspace"

    done
  done

  echo -e "${TAIL}" >>"${HOME}/dev.code-workspace"

  echo "code -r ${HOME}/dev.code-workspace"
}

function main() {
  install_pip_requirements
  pre_commit
  
  ## OPTIONAL: If you have mounted your local workspace,
  ## this function creates a vscode workspace file for each
  ## directory in your workspace directory
  # create_code_workspace
}

main "${@}"
