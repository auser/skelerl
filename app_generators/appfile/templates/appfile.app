{application, APPNAME,
  [
		% Quick description of the server
		{description, "Description of the application"},
		% Version
		{vsn, "0.0.1"},
		% All modules used by the application.  
		{modules, []},
		% All the registered names in the application
		{registered, []},
		% These must be started for application to run
		{applications, [kernel, stdlib]},
		% Environment vars
		{env, []},
		% Module and Args used to start
		{mod, {[]}},
		{start_phases, []}
	]
}.