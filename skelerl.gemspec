Gem::Specification.new do |s|
  s.name = %q{skelerl}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ari Lerner"]
  s.date = %q{2009-01-21}
  s.default_executable = %q{build-app}
  s.description = %q{This skeleton app takes care of everything you'd need in an erlang application, but don't want to do yourself... hopefully.}
  s.email = ["arilerner@mac.com"]
  s.executables = ["build-app"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.rdoc", "Rakefile", "bin/build-app", "config/hoe.rb", "config/requirements.rb", "ebin/packager.app", "include/empty", "lib/skelerl.rb", "setup.rb", "src/packager.erl", "tasks/deployment.rake", "tasks/environment.rake", "tasks/skelerl.rake", "tasks/website.rake"]
  s.has_rdoc = true
  s.homepage = %q{http://skelerl.rubyforge.org}
  s.post_install_message = %q{}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{skelerl}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{This skeleton app takes care of everything you'd need in an erlang application, but don't want to do yourself... hopefully.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_development_dependency(%q<hoe>, [">= 1.8.2"])
    else
      s.add_dependency(%q<hoe>, [">= 1.8.2"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.8.2"])
  end
end