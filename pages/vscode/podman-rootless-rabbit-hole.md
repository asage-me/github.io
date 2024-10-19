---
layout: page
title: Podman Rootless Rabbit Hole
---

- I spent many many hours trying to get Podman Desktop in rootless mode to work with the Dev Containers for Jekyll.  I was able to make it work with rootful containers, but that defeats the purpose of using Podman in my opinion.  You might as well just use Docker and not have to modify any of the .devcontainer files.  Since my goal was to get this working with Podman rootless, I have accepted for now that it will not work with the Jekyll Dev Container and I am using Docker Desktop.  I believe I tracked down the reason I was not able to get it to work with rootless containers to the way the features are installed.  Features are installed using docker-in-docker, which is an interesting choice in my opinion, but none the less how it is done.  It should be possible to add all the feature install operations directly to the .devcontainer/devcontainer.json and Dockerfile but that would require hours of work that I'm not willing to spend on it right now.  [Here is a github issue](https://github.com/microsoft/vscode-remote-release/issues/7915) someone posted that said they were able to work around the docker-in-docker issue by doing this
- If you want to run in Podman rootful mode, [here](https://gist.github.com/asagedev/94a91dad022d62599dac835103d2316f) are the files you need to modify in your `.devcontainer` directory and [here](https://code.visualstudio.com/remote/advancedcontainers/docker-options#_podman) are the settings you need to change in VSCode.  [Here](https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user) is some more info on nonroot users in Dev Containers
- In   the Gist above you can change the `Dockerfile` line 4 to `USER vscode` or `USER 1000` to try in rootless mode
- Here are some more useful links if you are curious about digging in to this deeper
  - [Jekyll Dev Container Image source](https://github.com/devcontainers/images/tree/main/src/jekyll)
  - [Node Dev Container Feature Source](https://github.com/devcontainers/features/tree/main/src/node)
    - In the `install.sh` script there is a line that says `Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.` I have been unable to find any reason this needs to be run as root, other than the docker-in-docker issue mentioned above
- Here is the error I receive when trying to build with Podman rootless
  ![Podman Rootless Jekyll Error.png](/assets/img/vscode/podman-rootless-jekyll-error.png)
  ```text

  [10868 ms] Start: Run: docker buildx build --load --build-arg BUILDKIT_INLINE_CACHE=1 -f /tmp/devcontainercli-root/container-features/0.71.0-1728139635351/Dockerfile-with-features -t vsc-github.io-9b3f773ef24c73d17dc6db159af1b5e10fba9db74aa7b08cbaf81ab754b79eaa --target dev_containers_target_stage --build-context dev_containers_feature_content_source=/tmp/devcontainercli-root/container-features/0.71.0-1728139635351 --build-arg _DEV_CONTAINERS_BASE_IMAGE=dev_container_auto_added_stage_label --build-arg _DEV_CONTAINERS_IMAGE_USER=vscode --build-arg _DEV_CONTAINERS_FEATURE_CONTENT_SOURCE=dev_container_feature_content_temp /workspaces/github.io/.devcontainer
  [+] Building 0.5s (1/1) FINISHED                                                                                                                                                                                                                                                                    docker-container:default
  => ERROR [internal] booting buildkit                                                                                                                                                                                                                                                                                   0.5s
  => => starting container buildx_buildkit_default                                                                                                                                                                                                                                                                       0.5s
  ------
  > [internal] booting buildkit:
  ------
  ERROR: Error response from daemon: crun: create `/sys/fs/cgroup/docker`: Permission denied: OCI permission denied
  [11409 ms] Error: Command failed: docker buildx build --load --build-arg BUILDKIT_INLINE_CACHE=1 -f /tmp/devcontainercli-root/container-features/0.71.0-1728139635351/Dockerfile-with-features -t vsc-github.io-9b3f773ef24c73d17dc6db159af1b5e10fba9db74aa7b08cbaf81ab754b79eaa --target dev_containers_target_stage --build-context dev_containers_feature_content_source=/tmp/devcontainercli-root/container-features/0.71.0-1728139635351 --build-arg _DEV_CONTAINERS_BASE_IMAGE=dev_container_auto_added_stage_label --build-arg _DEV_CONTAINERS_IMAGE_USER=vscode --build-arg _DEV_CONTAINERS_FEATURE_CONTENT_SOURCE=dev_container_feature_content_temp /workspaces/github.io/.devcontainer
  [11409 ms]     at RtA (/root/.vscode-remote-containers/dist/dev-containers-cli-0.388.0/dist/spec-node/devContainersSpecCLI.js:466:1933)
  [11409 ms]     at async _m (/root/.vscode-remote-containers/dist/dev-containers-cli-0.388.0/dist/spec-node/devContainersSpecCLI.js:465:1896)
  [11409 ms]     at async bH (/root/.vscode-remote-containers/dist/dev-containers-cli-0.388.0/dist/spec-node/devContainersSpecCLI.js:465:610)
  [11409 ms]     at async TtA (/root/.vscode-remote-containers/dist/dev-containers-cli-0.388.0/dist/spec-node/devContainersSpecCLI.js:482:3848)
  [11409 ms]     at async iB (/root/.vscode-remote-containers/dist/dev-containers-cli-0.388.0/dist/spec-node/devContainersSpecCLI.js:482:4963)
  [11409 ms]     at async wrA (/root/.vscode-remote-containers/dist/dev-containers-cli-0.388.0/dist/spec-node/devContainersSpecCLI.js:663:203)
  [11410 ms]     at async DrA (/root/.vscode-remote-containers/dist/dev-containers-cli-0.388.0/dist/spec-node/devContainersSpecCLI.js:662:14830)
  [11410 ms]     at async /root/.vscode-remote-containers/dist/dev-containers-cli-0.388.0/dist/spec-node/devContainersSpecCLI.js:482:1190
  [11504 ms] Exit code 1
  [11505 ms] Start: Run: podman rm -f e9858fd12e7ac90149481df7be61b415eaa61d681cb4fa496b38a7862650cf98
  [11506 ms] Command failed: node /root/.vscode-remote-containers/dist/dev-containers-cli-0.388.0/dist/spec-node/devContainersSpecCLI.js up --container-session-data-folder /tmp/devcontainers-e4d64a0b-1c6b-4cff-aad6-ec92bf247eab1728139625387 --workspace-folder /workspaces/github.io --workspace-mount-consistency cached --gpu-availability detect --id-label vsch.local.repository=https://github.com/asagedev/github.io.git/tree/podman-test --id-label vsch.local.repository.volume=vsc-remote-containers --id-label vsch.local.repository.folder=github.io --id-label devcontainer.config_file=/workspaces/github.io/.devcontainer/devcontainer.json --log-level debug --log-format json --config /workspaces/github.io/.devcontainer/devcontainer.json --override-config /tmp/devcontainer-387fdfea-b9db-4ce2-882d-6d5eff53935c.json --default-user-env-probe loginInteractiveShell --mount type=volume,source=vsc-remote-containers,target=/workspaces,external=true --mount type=volume,source=vscode,target=/vscode,external=true --skip-post-create --update-remote-user-uid-default off --mount-workspace-git-root --terminal-columns 317 --terminal-rows 35 --include-configuration --include-merged-configuration
  [11506 ms] Exit code 1
  ```
