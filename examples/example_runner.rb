
erlang do
  options do 
    path  "ebin"
    cookie "chordjerl"
  end
  
  with_node(:node0, :stop => false) do
    start
  end
end