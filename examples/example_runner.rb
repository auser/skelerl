$:.unshift(File.dirname(__FILE__)+"/../lib")
require "rubygems"
require "skelerl"

erlang do
  testing true
  
  options :path => "./ebin", :cookie => "chordjerl"
  
  with_node(:node0, :stop => false) do
    start
  end
  
  with_node(:node1) do
    start
  end
  
end