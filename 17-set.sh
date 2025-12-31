#!/bin/bash

set -ex

function(){
    echo "failed at $1:$2"
}

trap 'function "${LINENO}" "${BASH_COMMAND}"' ERR #ERR is for error signal

echo "Hello world success"
echhhh "Hello world failure"
echo "Hello world after failure"