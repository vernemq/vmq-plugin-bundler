FROM erlang:21-alpine

RUN apk add git curl bash

ADD run.sh rebar.config rebar.config.script ./
# TODO: fix the rebar.lock.script
# ADD rebar.lock.script ./

CMD ./run.sh

