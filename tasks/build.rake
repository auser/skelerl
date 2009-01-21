require 'rake/clean'

INCLUDE = "include"
ERLC_FLAGS = "-I#{INCLUDE} +warn_unused_vars +warn_unused_import"

SRC = FileList['src/*.erl']
OBJ = SRC.pathmap("%{src,ebin}X.beam")
CLEAN.include("ebin/*.beam")

directory 'ebin'

rule ".beam" =>  ["%{ebin,src}X.erl"] do |t|
  sh "erlc -pa ebin -W #{ERLC_FLAGS} -o ebin #{t.source}"
end

task :default => :compile

desc "Run the tests"
task :run_tests => [:compile] do
  OBJ.each do |obj|
    obj[%r{.*/(.*).beam}]
    mod = $1
    test_output = `erl -pa ebin -run #{mod} test -run init stop`

    if /\*failed\*/ =~ test_output
      test_output[/(Failed.*Aborted.*Skipped.*Succeeded.*$)/]
    else
      test_output[/1>\s*(.*)\n/]
    end
  end
end

desc "Clean the beams from the ebin directory"
task :clean do
  # cmd = "rm #{::File.dirname(__FILE__)}/ebin/*.beam"
  # Kernel.system cmd
end

desc "Recompile the sources"
task :recompile => [:clean, :compile]

desc "Compile all the sources"
task :compile => ['ebin'] + OBJ

desc "Compile with the DEBUG flag set to true"
task :compile_debug do
  Dir["#{::File.dirname(__FILE__)}/src/*.erl"].each do |t|
    Kernel.system "erlc -pa ebin -W #{ERLC_FLAGS} -Ddebug -o ebin #{t}"
  end
end

desc "Rebuild the boot scripts"
task :build_boot_scripts => [:recompile] do
  puts "Rebuilding boot scripts"
  
  root_dir = ::File.expand_path( ::File.join(::File.dirname(__FILE__)) )
  @version = ENV["VERSION"] || ENV["V"] || "0.1"
  @name = ENV["NAME"] || ::File.basename(::File.dirname( root_dir ))
  
  cmd = "erl -pa ./ebin/ -run packager start #{@name} #{@version} -run init stop -noshell"
  Kernel.system cmd
end

desc "Rebuild and repackage"
task :repackage => [:build_boot_scripts] do  
  cmd = "erl -pa ./ebin -s packager start -s init stop"
  Kernel.system cmd
end

desc "Install messenger"
task :install_messenger do
  cmd = "erl -pa ./ebin/ -run packager install_messenger #{@version} -run init stop -noshell"
  Kernel.system cmd
end