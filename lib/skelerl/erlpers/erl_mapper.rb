class ErlMapper
  include Dslify
  
  def initialize(&block)
    instance_eval &block if block
  end
  
  default_options({
    :path => "./ebin",
    :sname => "node0",
    :cookie => nil,
    :stop => true,
    :testing => true
  })
  
  def self.erl_methods(hash={})
    puts "in erl_methods with #{hash}"
    hash.each {|k,v| define_method "erl_#{k}" do;"#{v}";end}
  end
  
  erl_methods(:path => "pa", :cookie => "setcookie")
  
  def options(opts={}, &block)
    set_vars_from_options opts
    instance_eval &block if block
  end
  
  def with_node(name="node0", opts={}, &block)
    MappingContext.new name, __options, &block
  end
  
end

class MappingContext < ErlMapper
  attr_accessor :sname, :parent
  
  def initialize(name, opts={}, &block)
    @sname = name
    @opts = opts
    instance_eval &block if block
  end
  
  def namespace name, &block
    Namespace.new(name, @opts, &block)
  end
  
  def string
    "#{build_string} #{start_commands} #{final_commands}"
  end
  
  def final_commands
    returning Array.new do |arr|
      arr << "-s init stop" if opts.has_key?(:stop) && opts[:stop]
    end.join(" ")
  end
    
  def build_string
    @build_string ||= 
      "erl #{opts.collect {|k,v| "-#{get_opt_name(k)} #{v} " if v && v.is_a?(String)}}"
  end
  
  def get_opt_name(k)
    puts methods.include?("erl_#{k}".to_sym)
    methods.include?("erl_#{k}".to_sym) ? self.send("erl_#{k}".to_sym) : "#{k}"
  end
  
  def opts;@opts ||= {};end
  def start_commands;@commands.collect {|c| "-s #{c}"};end
  def commands;@commands ||= [];end
  
  def method_missing(m, *args, &block)
    command = "#{m}#{ " #{args.join(" ")}" unless args.empty?}"
    commands.push command
  end
end

class Namespace < MappingContext
  def start_commands
    commands.collect {|c| "-s #{namespace}:#{c}"}
  end
end