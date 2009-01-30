class ErlMapper
  include Dslify

  def initialize(opts={}, &block)
    @opts = opts
    instance_eval &block if block
  end
  
  default_options({
    :path => "./ebin",
    :sname => "node0",
    :cookie => nil,
    :stop => true
  })
  
  def opts;@opts ||= {};end
  
  def self.erl_methods(hash={})
    hash.each {|k,v| define_method "erl_#{k}" do;"#{v}";end}
  end
  
  erl_methods(:path => "pa", :cookie => "setcookie")
  
  def options(opts={}, &block)
    set_vars_from_options opts
    instance_eval &block if block
  end
  
  def contexts
    @contexts ||= []
  end
  
  def with_node(name="node0", opts={}, &block)
    returning MappingContext.new(name, __options.merge(opts), &block) do |mc|
      contexts << mc
    end
  end
  
  def realize(force_testing=false)
    contexts.collect {|mc| (force_testing || testing) ? mc.string : daemonize(mc.string) }
  end
  
  def daemonize(cmd, &block)
    pid = fork do
      Signal.trap('HUP', 'IGNORE') # Don't die upon logout
      File.open("/dev/null", "r+") do |devnull|
        $stdout.reopen(devnull)
        $stderr.reopen(devnull)
        $stdin.reopen(devnull) unless @use_stdin
      end
      Kernel.system cmd
      block.call if block
    end
    Process.detach(pid)
    pid
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
    "#{build_string} #{start_commands} #{final_commands}".strip
  end
  
  def final_commands
    returning Array.new do |arr|
      arr << "-s init stop" if (opts.has_key?(:stop) && opts[:stop])
    end.join(" ")
  end
    
  def build_string
    @build_string ||= 
      "erl #{opts.collect {|k,v| "-#{get_opt_name(k)} #{v} " if v && v.is_a?(String)}}"
  end
  
  def get_opt_name(k);methods.include?("erl_#{k}") ? self.send("erl_#{k}".to_sym) : "#{k}";end
    
  def start_commands;commands.collect {|c| "-s #{c}"};end
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