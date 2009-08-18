require 'config/requirements'

begin
  require 'hanna/rdoctask'
rescue LoadError => e
  require "rake/rdoctask"
end

require 'config/jeweler' # setup gem configuration

Dir['tasks/**/*.rake'].each { |rake| load rake }