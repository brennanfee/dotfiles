# Pipx Packages

I use pipx to install python "apps" that are deployed from pip. They end up being
"global" as in available in my terminal without the need to put in a path and will
override any system-wide installed versions of the tools.

## Install Pipx

New way:

```sh
sudo apt install pipx
```

Old way:

```sh
python3 -m pip install --user pipx
python3 -m pipx ensurepath
```

## Upgrading Pipx

Old way:

```sh
python3 -m pip install --user -U pipx
```

## The packages

```sh
pipx install --include-deps ansible
pipx inject ansible cryptography
pipx inject ansible paramiko
pipx inject ansible dnspython

pipx install molecule
pipx inject molecule molecule-plugins
pipx inject molecule molecule-plugins[vagrant]
pipx inject molecule python-vagrant

pipx install invoke
pipx install poetry
#pipx install streamdeck-ui
pipx install youtube-dl
pipx install yt-dlp
```
