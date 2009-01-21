{application, packager,
  [
		% Quick description of the server
		{description, "Package manager"},
		% Version
		{vsn, "0.1"},
		% All modules used by the application.  
		{modules, [packager_app]},
		% All the registered names in the application
		{registered, [packager]},
		% These must be started for application to run
		{applications, [kernel, stdlib]},
		% Environment vars
		{env, []},
		% Module and Args used to start
		{mod, {packager_app, []}},
		{start_phases, []}
	]
}.