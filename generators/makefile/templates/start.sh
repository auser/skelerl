#!/bin/sh
# start.sh
cd `dirname $0`
erl -pa $PWD/ebin -pa $PWD/deps/*/ebin -name <%= app_name -%> -s reloader -boot <%= app_name -%> $1