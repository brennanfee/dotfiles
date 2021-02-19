# Pipx Packages

I use pipx to install python "apps" that are deployed from pip. They end up being
"global" as in available in my terminal without the need to put in a path and will
override any system-wide installed versions of the tools.

## Install Pipx

```sh
python3 -m pip install --user pipx
python3 -m pipx ensurepath
```

## Upgrading Pipx

```sh
python3 -m pip install --user -U pipx
```

## The packages

```sh
pipx install --include-deps ansible
pipx install ansible-lint
pipx install black
pipx install flake8
pipx install molecule
pipx install poetry
pipx install yamllint
pipx install youtube-dl
```
