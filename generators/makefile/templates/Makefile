LIBDIR					= `erl -eval 'io:format("~s~n", [code:lib_dir()])' -s init stop -noshell`
VERSION					= <%= version -%>
CC							= erlc
ERL							= erl
EBIN						= ebin
CFLAGS					= -I include -pa $(EBIN)
COMPILE					= $(CC) $(CFLAGS) -o $(EBIN)
EBIN_DIRS				= $(wildcard deps/*/ebin)
WEB_DIR					= web/
APP							= <%= app_name %>

all: ebin compile boot

compile:
	@$(ERL) -pa $(EBIN_DIRS) -noinput +B -eval 'case make:all() of up_to_date -> halt(0); error -> halt(1) end.'

edoc:
	@echo Generating $(APP) documentation from srcs
	@$(ERL) -noinput -eval 'edoc:application($(APP), "./", [{doc, "doc/"}, {files, "src/"}])' -s erlang halt
	
boot:
	(cd ebin; erl -pa ebin -noshell -run make_boot write_scripts $(APP))

start_all:
	(cd ebin; erl -pa ebin -noshell -boot $(APP))

ebin:
	@mkdir ebin

clean:
	rm -rf ebin/*.beam ebin/erl_crash.dump erl_crash.dump ebin/*.boot ebin/*.rel ebin/*.script 