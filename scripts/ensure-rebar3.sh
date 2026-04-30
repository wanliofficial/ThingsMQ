#!/usr/bin/env bash

set -euo pipefail

## rebar3 tag 3.18.0-emqx-1 is compiled using otp24.1.5.
## we have to use an otp24-compiled rebar3 because the defination of record #application{}
## in systools.hrl is changed in otp24.
case ${OTP_VSN} in
    23*)
        VERSION="3.14.3-emqx-8"
        ;;
    24*)
        VERSION="3.18.0-emqx-1"
        ;;
    25*)
        VERSION="3.19.0-emqx-9"
        ;;
    26*)
        VERSION="3.20.0-emqx-5"
        ;;
    27*)
        VERSION="3.24.0-emqx-1"
        ;;
    28*)
        VERSION="3.25.1-emqx-1"
        ;;
    *)
        echo "Unsupported Erlang/OTP version $OTP_VSN"
        exit 1
        ;;
esac

echo "OTP Version: ${OTP_VSN}, using rebar3 version: ${VERSION}"

# ensure dir
cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")/.."

DOWNLOAD_URL='https://github.com/emqx/rebar3/releases/download'

download() {
    echo "downloading rebar3 ${VERSION}"
    curl -f -L "${DOWNLOAD_URL}/${VERSION}/rebar3" -o ./rebar3
}

# get the version number from the second line of the escript
# because command `rebar3 -v` tries to load rebar.config
# which is slow and may print some logs
version() {
    head -n 2 ./rebar3 | tail -n 1 | tr ' ' '\n' | grep -E '^.+-emqx-.+'
}

if [ -f 'rebar3' ] && [ "$(version)" = "$VERSION" ]; then
    exit 0
fi

# download # 直接使用根目录下的rebar3即可，是在emqx/rebar3 targ为 3.18.0-emqx-1的源码，修改若干代码，通过erlang 27编译而来
chmod +x ./rebar3
