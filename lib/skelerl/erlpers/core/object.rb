class Object
  # Erlang block where you can register map erlang directives
  # Usage:
  #   erlang do
  #     with_node(:node0) do
  #       start
  #     end
  #   end
  def erlang parent=self, &block
    context_stack.push parent
    mapper = block ? ErlMapper.new(&block) : nil
    mappers << mapper
    context_stack.pop
    
    testing ? puts(mapper.realize(true)) : mapper.realize(false)  
  end
  
  def testing bool=false
    $testing ||= bool
  end
  
  def mappers
    $mappers ||= []
  end
  
  # Context stack so we can keep track of the context
  def context_stack
    @@context_stack ||= []
  end
  
  def parent
    @@context_stack.first
  end
end