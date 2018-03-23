#!/usr/bin/env bash

if command_exists npm; then
    function npme {
        (PATH=$(npm bin);$PATH; eval $@;)
    }

    alias npmr='npm run'
fi

