class MappingContext < ErlMapper
  attr_accessor :sname, :parent
  
  def initialize(name, opts={}, &block)
    @__name = name
    @opts = opts
    instance_eval &block if block
    @sname ||= @__name
  end
  
  def string
    returning Array.new do |arr|
      %w(build_string start_commands final_commands).each {|meth| arr << self.send(meth).strip }
    end.join(" ").strip
  end
  
  def final_commands
    returning Array.new do |arr|
      arr << "-s init stop" if (opts.has_key?(:stop) && opts[:stop])
    end.join(" ")
  end
    
  def build_string
    @build_string ||= 
      "erl #{opts.map {|k,v| "-#{get_opt_name(k)} #{v}" if v && v.is_a?(String)}.join(" ")}"
  end
  
  def get_opt_name(k);methods.include?("erl_#{k}") ? self.send("erl_#{k}".to_sym) : "#{k}";end
    
  def start_commands;commands.map {|c| "-s #{c}"}.join(" ");end
  def commands;@commands ||= [];end
  def parent_string; parent ? parent.__name : nil; end
  
  def method_missing(m, *args, &block)
    command = Command.new(m, args).flatten
    commands.include?(command) ? super : commands.push(command)
    command
  end
end