%w(build).each do |rake|
  load "#{File.dirname(__FILE__)}/../tasks/#{rake}.rake"
end

module Skelerl
  module VERSION
    STRING = "0.0.4"
  end
end