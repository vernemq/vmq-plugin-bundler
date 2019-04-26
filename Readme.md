# vmq-plugin-bundler

The resulting Docker image can be used to build VerneMQ plugins that
comply with the dependencies that are already used in the given
VerneMQ version.

E.g. if your plugin relies on the Hackney HTTP library it has to make
sure that it uses the same version of Hackney as it is used in VerneMQ.
When building the plugin(s) with this Docker image we force the
plugin dependencies to use the same versions as the ones used by VerneMQ.

Additionally the Docker image bundles the plugin folder into 
an archive named `bundle.tar.gz` and serves this file via HTTP.
This simplifies the story when one wants to use a custom plugin in
a dockerized VerneMQ environment.

## Configuration

Multiple Environment variable can be set:

- `VERNEMQ_VERSION` is used to set the VerneMQ Version. Defaults to `master`.
- `HTTP_ADDRESS` is used to set the IP address the HTTP server accepts connections. Defaults to `0.0.0.0`.
- `HTTP_PORT` is used to set the TCP port of the HTTP listener. Defaults to `8080`.
- `BUNDLER_CONFIG` is used to specify the source of the plugin, usually one or more Git addresses. `BUNDLER_CONFIG` is either a string containing the whole config, or a file name pointing to a file containing the whole config. For now the format of the config is exactly the one of a `rebar3` config file. See https://www.rebar3.org/docs/dependencies#section-declaring-dependencies.

## Example

    docker run -p 8080:8080 -e BUNDLER_CONFIG="{deps, [{myplugin, {git, "git://github.com/mycompany/myplugin.git, {tag, "1.0.0"}}}]}." vernemq/vmq-plugin-bundler


The resulting `bundler.tar.gz` can be downloaded via `wget http://localhost:8080/bundle.tar.gz` 
and contains all compiled artefacts used to enable a VerneMQ plugin with

`vmq-admin plugin enable -n myplugin -p <EXTRACTED_ARCIVE>/_build/default`

