# pyfa-docker
Install and run pyfa in a docker container


## Prerequisites
 - `docker` installed
 - Docker daemon running (`systemctl docker start`).
 - Current user must have access to the daemon (`sudo usermod -a -G docker $(whoami)`).

## Installation
Clone this repo anywhere. Run `pyfa-docker.sh`.

To have a desktop entry, edit the `Exec` field in `pyfa-docker.desktop` to point to `pyfa-docker.sh`, and place the file wherever your .desktop files live (typically `$HOME/.local/share/applications/`). Place the icon wherever your icons live (typically `$HOME/.local/share/icons/hicolor/72x72/apps/`).

To update, simply change `CURRENT_VERSION` in `pyfa-docker.sh`, and re-run `pyfa-docker.sh`.