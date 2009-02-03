Dir["#{File.dirname(__FILE__)}/core/*.rb"].each {|f| require f if ::File.file? f}

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
  
  def namespace name, &block
    Namespace.new(name, @opts, &block)
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

Dir["#{File.dirname(__FILE__)}/mappers/*.rb"].each {|f| require f if ::File.file? f}