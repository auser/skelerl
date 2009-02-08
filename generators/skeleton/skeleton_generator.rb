require 'rbconfig'

class SkeletonGenerator < RubiGen::Base
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
      # Root directory and all subdirectories.
      m.directory ''
      BASEDIRS.each { |path| m.directory path }
      
      # Root
      m.template_copy_each %w( Rakefile )
      m.file_copy_each     %w( README.txt )

      # Test helper
      m.template   "gitignore",        ".gitignore"
      
      # Tests
      %w(ebin include src).each do |directory|
        m.directory "test/#{directory}"
      end
      
      include_eunit
      include_configerl
         
    end
  end
  
  def include_eunit
    cmds = [
      "svn co http://svn.process-one.net/contribs/trunk/eunit #{@destination_root}/test/include/eunit",
      "cd #{@destination_root}/test/include/eunit",
      "make"
    ]
    Kernel.system cmds.join(" && ")
  end
  def include_configerl
    cmds = [
      "git submodule add git://github.com/auser/configerl.git #{@destination_root}/deps/configerl",
      "git submodule init",
      "git submodule update"
    ]
    Kernel.system cmds.join(" && ")
  end

  protected
    def banner
      <<-EOS
Create a stub for #{File.basename $0} to get started.

Usage: #{File.basename $0} /path/to/your/app [options]"
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

  BASEDIRS = %w(deps doc ebin include priv scripts src support)
  BASEFILES = %w(README.txt Rakefile)
end
