# devcontainer-bash

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)

## What is a Dev-Container?

A Dev-Container is used to create a clean and use-cased development environment via vscode and Docker.
In this case, I've defined a Dockerfile using an Debian11 OS and I've defined some vscode extensions that are useful to write and debug Python code.

## Requirements

### Docker

[Install Docker (Desktop)](https://docs.docker.com/get-docker/)

### Microsoft Visual Studio Code

Download and install [vscode](https://code.visualstudio.com/)

### vscode extensions

In vscode, install extension [ms-vscode-remote.remote-containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## How to use

1. Start docker engine
1. Clone this repository
1. Open the local repository in vscode
1. If you want to mount your local workspace directory into the devcontainer, modify [.devcontainer.json](./.devcontainer/devcontainer.json) Section `"mounts": [ "source=${localEnv:HOME}${localEnv:USERPROFILE}/workspace,target=/home/vscode/workspace,type=bind,consistency=cached"]` to fit your workspace path.
1. In the popup at the lower right corner, click on "Reopen in Container"

## Pre-Commit

This devcontainer is set up to use `pre-commit` to do python formating and linting on every commit.
