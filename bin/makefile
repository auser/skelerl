#!/usr/bin/env ruby

require 'rubygems'
require 'rubigen'

if %w(-v --version).include? ARGV.first
  require 'makefile/version'
  puts "#{File.basename($0)} #{GenServer::VERSION::STRING}"
  exit(0)
end

require 'rubigen/scripts/generate'
source = RubiGen::PathSource.new(:application, 
  File.join(File.dirname(__FILE__), "../generators"))
RubiGen::Base.reset_sources
RubiGen::Base.append_sources source
RubiGen::Scripts::Generate.new.run(ARGV, :generator => 'makefile')
