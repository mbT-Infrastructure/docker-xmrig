#!/usr/bin/env bash
set -e -o pipefail

ADDITIONAL_ARGUMENTS=()
if [[ -n "$PROXY_URL" ]]; then
    ADDITIONAL_ARGUMENTS+=("--proxy" "${PROXY_URL#socks5://}")
fi

if [[ "$SERVER_URL" == *@(ssl|tls)://* ]]; then
    ADDITIONAL_ARGUMENTS+=("--tls")
fi

if [[ -n "$WORKER_ID" ]]; then
    ADDITIONAL_ARGUMENTS+=("--rig-id" "$WORKER_ID")
fi


xmrig "${ADDITIONAL_ARGUMENTS[@]}" --donate-level "$DONATE_LEVEL" --url "${SERVER_URL#*://}" \
    --user "$WALLET_ADDRESS" --pass "$PASSWORD" "$@"
