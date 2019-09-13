FROM erlang:21

ADD run.sh rebar.config rebar.config.script ./
# TODO: fix the rebar.lock.script
# ADD rebar.lock.script ./

CMD ./run.sh

