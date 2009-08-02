require 'rbconfig'

class GenServerGenerator < RubiGen::Base
  DEFAULT_SHEBANG = File.join(Config::CONFIG['bindir'],
                              Config::CONFIG['ruby_install_name'])
                              
  default_options   :shebang => DEFAULT_SHEBANG,
                    :an_option => 'some_default'
  
  attr_reader :app_name, :module_name
  
  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @destination_root = args.shift
    @app_name     = File.basename(File.expand_path(@destination_root))
    @module_name  = app_name.camelize
    extract_options
  end
    
  def manifest
    # Use /usr/bin/env if no special shebang was specified
    script_options     = { :chmod => 0755, :shebang => options[:shebang] == DEFAULT_SHEBANG ? nil : options[:shebang] }
    windows            = (RUBY_PLATFORM =~ /dos|win32|cygwin/i) || (RUBY_PLATFORM =~ /(:?mswin|mingw)/)
    
    record do |m|
      m.template "gen_server.erl", "src/#{gen_server_file_name}"
    end
  end

  def gen_server_file_name
    "#{module_name}.erl"
  end

  def module_name
    "#{name}_srv"
  end

  protected
    def banner
      <<-EOS
Create a stub for #{File.basename $0} to get started.

Usage: #{File.basename $0} gen_server_name [options]"
EOS
    end

    def add_options!(opts)
      opts.separator ''
      opts.separator "#{File.basename $0} options:"
      opts.on("-v", "--version", "Show the #{File.basename($0)} version number and quit.")
    end
    
    def extract_options
      # for each option, extract it into a local variable (and create an "attr_reader :author" at the top)
      # Templates can access these value via the attr_reader-generated methods, but not the
      # raw instance variable value.
      @author = options[:author]
      @description = options[:desc] || "Description of your project"
    end

  BASEDIRS = %w()
  BASEFILES = %w()
end
