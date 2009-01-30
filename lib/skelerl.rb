[File.expand_path(File.dirname(__FILE__))].each do |dir|
  $:.unshift(dir) unless $:.include?(dir)
end

require "rubygems"
%w(dslify rubigen).each do |gem|
  begin;require "#{gem}";rescue Exception => e;puts "Error: #{e}";end
end

require "skelerl/init"

%w(build).each do |rake|
  load "#{File.dirname(__FILE__)}/../tasks/#{rake}.rake"
end

module Skelerl
  
  module VERSION
    STRING = "0.0.1"
  end
  
end