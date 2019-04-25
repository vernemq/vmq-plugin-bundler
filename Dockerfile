FROM erlang:21

ADD run.sh rebar.config rebar.config.script ./

CMD ./run.sh

