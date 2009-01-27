class ErlMapper
  include Dslify
  
  def initialize(&block)
    instance_eval &block if block
  end
  
  default_options({
    :path => ["pa", "./ebin"],
    :sname => ["sname", "node0"],
    :stop => true,
    :testing => true
  })
  
  def options(opts={}, &block)
    set_vars_from_options opts
    instance_eval &block if block
  end
  
  def with_node(name="node0", opts={}, &block)
    m = MappingContext.new name
    parent.dsl_options.each {|k,v| m.take_options(v)}
  end
end

class MappingContext
  attr_accessor :name, :string
  
  def initialize(name)
    @name = name
  end
  
  def take_options(value)
    build_string += "-#{value[0]} #{value[1]} " if value.is_a?(Array)
  end
  
  def build_string
    @build_string ||= "erl "
  end
end