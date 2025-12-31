#!/bin/bash

set -ex

failure(){
    echo "failed at $1:$2"
}

trap 'failure "${LINENO}" "${BASH_COMMAND}"' ERR #ERR is for error signal

echo "Hello world success"
echhhh "Hello world failure"
echo "Hello world after failure"