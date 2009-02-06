# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{skelerl}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ari Lerner"]
  s.date = %q{2009-02-06}
  s.description = %q{This skeleton app takes care of everything you'd need in an erlang application, but don't want to do yourself... Check out the README for more!}
  s.email = ["arilerner@mac.com"]
  s.executables = ["appfile", "build-app", "erl_runner", "gen_server"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "app_generators/appfile/USAGE", "app_generators/appfile/appfile_generator.rb", "app_generators/appfile/templates/appfile.app", "app_generators/gen_server/USAGE", "app_generators/gen_server/gen_server_generator.rb", "app_generators/gen_server/templates/gen_server.erl", "bin/appfile", "bin/build-app", "bin/erl_runner", "bin/gen_server", "config/hoe.rb", "config/requirements.rb", "ebin/packager.app", "examples/example_runner.rb", "include/empty", "lib/skelerl.rb", "lib/skelerl/core/object.rb", "lib/skelerl/erlpers/core/array.rb", "lib/skelerl/erlpers/core/object.rb", "lib/skelerl/erlpers/erl_mapper.rb", "lib/skelerl/erlpers/mappers/command.rb", "lib/skelerl/erlpers/mappers/context.rb", "lib/skelerl/erlpers/mappers/namespace.rb", "lib/skelerl/init.rb", "script/generate", "setup.rb", "skelerl.gemspec", "src/packager.erl", "tasks/build.rake", "tasks/deployment.rake", "tasks/environment.rake", "tasks/generate.rake", "tasks/website.rake", "test/erlpers/erl_mapper_spec.rb", "test/erlpers/object_spec.rb", "test/helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://skelerl.rubyforge.org}
  s.post_install_message = %q{}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{skelerl}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{This skeleton app takes care of everything you'd need in an erlang application, but don't want to do yourself... Check out the README for more!}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end