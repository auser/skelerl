-module (packager).
-compile(export_all).
-behaviour(application).

%% Application callbacks
-export([start/1, start/2, stop/1]).

start(Name) -> 
	[N,V] = Name,
	start(N, V).
%%====================================================================
%% Application callbacks
%%====================================================================
%%--------------------------------------------------------------------
%% Function: start(Type, StartArgs) -> {ok, Pid} |
%%                                     {ok, Pid, State} |
%%                                     {error, Reason}
%% Description: This function is called whenever an application
%% is started using application:start/1,2, and should start the processes
%% of the application. If the application is structured according to the
%% OTP design principles as a supervision tree, this means starting the
%% top supervisor of the tree.
%%--------------------------------------------------------------------
start(Name, Version) -> 	
	recompile_scripts(Name, Version).

%%--------------------------------------------------------------------
%% Function: stop(State) -> void()
%% Description: This function is called whenever an application
%% has stopped. It is intended to be the opposite of Module:start/2 and
%% should do any necessary cleaning up. The return value is ignored.
%%--------------------------------------------------------------------
stop(_State) ->
  ok.

%%====================================================================
%% Internal functions
%%====================================================================

gen_rel(Name, Vers) ->
		RelName = gen_rel_name(Name, Vers),
    F = lists:append(["{release, {\"",Name,"\",\"",Vers,"\"}, ",
                      "{erts,\"",erlang:system_info(version),"\"},"
                      "[{kernel,\"",get_vsn(kernel),"\"},",
                      "{stdlib,\"",get_vsn(stdlib),"\"},",
                      "{inets,\"",get_vsn(inets),"\"},",
                      "{crypto,\"",get_vsn(crypto),"\"},",
                      "{sasl,\"",get_vsn(sasl),"\"},",
                      "{",Name,",\"",Vers,"\"}]}."]),
	file:write_file( lists:append(["ebin/", RelName, ".rel"]),F).

% Recompiles the boot scripts
recompile_scripts(Name, Vers) ->
	gen_rel(Name, Vers),
	ScriptName = gen_rel_name(Name, Vers),
	systools:make_script(ScriptName, [local,{path,["ebin"]}]).

package_scripts(Name, Vers) ->
	ScriptName = lists:append(["ebin/", gen_rel_name(Name, Vers)]),
	systools:make_tar(ScriptName).

get_vsn(Module) ->
    AppFile = code:lib_dir(Module)++"/ebin/"++atom_to_list(Module)++".app",
    {ok,[{application,_App,Attrs}]} = file:consult(AppFile),
    {value,{vsn,Vsn}} = lists:keysearch(vsn,1,Attrs),
    Vsn.

gen_rel_name(Name, Vers) -> lists:append([Name,"_rel-",Vers]).

install_messenger(Vers) ->
	Root = code:root_dir(),
	io:format("~p root: "++Root, [Vers]),
	ok.

% Tests
