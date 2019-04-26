FROM erlang:21

ADD run.sh rebar.config rebar.config.script rebar.lock.script ./

CMD ./run.sh

