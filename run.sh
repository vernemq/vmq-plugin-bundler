#!/usr/bin/env bash

rebar3 compile
find -L _build/default -regex ".*\/\(ebin\|priv\)\/.*" -print0 | tar -czvf bundle.tar.gz --null -T -
mkdir -p bundler
mv bundle.tar.gz bundler/.
erl -s inets -eval "{ok, _} = inets:start(httpd, [{port, ${HTTP_PORT:-8080}}, {document_root, \"$PWD/bundler\"}, {bind_address, \"${HTTP_ADDRESS:-0.0.0.0}\"}, {server_name, \"vmq_plugin_bundler\"}, {server_root, \"$PWD/bundler\"}])." -noshell -noinput
