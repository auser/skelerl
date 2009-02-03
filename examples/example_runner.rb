$:.unshift(File.dirname(__FILE__)+"/../lib")
require "rubygems"
require "skelerl"

erlang do
  testing true
  
  options :path => "./ebin", :cookie => "chordjerl"
  
  with_node(:node0, :stop => false) do
    start
  end
  
  with_node(:node2) do
    erlang_module.go
  end
  
  with_node(:node1) do
    namespace :erlang_module do
      start
    end
  end
  
end