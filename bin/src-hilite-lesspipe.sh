#! /bin/bash

for source in "$@"; do
    case $source in
	*ChangeLog|*changelog)
        source-highlight --failsafe -f esc256 --lang-def=changelog.lang --style-file=esc256.style -i "$source" ;;
	*Makefile|*makefile)
        source-highlight --failsafe -f esc256 --lang-def=makefile.lang --style-file=esc256.style -i "$source" ;;
	*.tar|*.tgz|*.gz|*.bz2|*.xz)
        lesspipe "$source" ;;
        *) source-highlight --failsafe --infer-lang -f esc256 --style-file=esc256.style -i "$source" ;;
    esac
done
