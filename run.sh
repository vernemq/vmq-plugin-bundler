#!/usr/bin/env bash
set -e

curl https://raw.githubusercontent.com/vernemq/vernemq/${VERNEMQ_VERSION:-master}/rebar.lock --output vernemq.rebar.lock
rebar3 get-deps
rm -Rf _build
rebar3 compile
find -L _build/default/lib -regex ".*\/\(plugins\|ebin\|priv\)\/.*" -print0 | tar -czvf bundle.tar.gz --null -T -
mkdir -p bundler
mv bundle.tar.gz bundler/.
echo "Serving bundle on http://${HTTP_ADDRESS:-0.0.0.0}:${HTTP_PORT:-8080}/bundle.tar.gz"
erl -s inets -eval "{ok, _} = inets:start(httpd, [{port, ${HTTP_PORT:-8080}}, {document_root, \"$PWD/bundler\"}, {bind_address, \"${HTTP_ADDRESS:-0.0.0.0}\"}, {server_name, \"vmq_plugin_bundler\"}, {server_root, \"$PWD/bundler\"}])." -noshell -noinput
