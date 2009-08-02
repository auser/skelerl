class MakefileGenerator < RubiGen::Base

  DEFAULT_SHEBANG = File.join(Config::CONFIG['bindir'],
                              Config::CONFIG['ruby_install_name'])

  default_options :author => nil

  attr_reader :app_name, :version

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @app_name = args.shift
    @destination_root = File.expand_path(".")
    @name = base_name    
    extract_options
  end

  def manifest    
    record do |m|
      m.template "Makefile", "Makefile"
      m.template "Emakefile", "Emakefile"
      m.directory "ebin"
      m.template "appfile.app.erb", "ebin/#{@app_name}.app"
      m.template "start.sh", "start.sh", { :chmod => 0755 }
      m.directory "src"
      m.template "make_boot.erl.erb", "src/make_boot.erl"
    end
  end

  protected
    def banner
      <<-EOS
Creates a makefile project with a bootscript generator

USAGE: #{spec.name} name
EOS
    end

    def add_options!(opts)
      opts.separator ''
      opts.separator 'Options:'
      # For each option below, place the default
      # at the top of the file next to "default_options"
      # opts.on("-a", "--author=\"Your Name\"", String,
      #         "Some comment about this option",
      #         "Default: none") { |options[:author]| }
      opts.on("-n", "--name", "Name the app") { |options[:app_name]| }
      opts.on("-d", "--desc", "Description of the app") { |options[:description]| }
      opts.on("-m", "--modules", "Modules used in the application") { |options[:modules]| }
      opts.on("-r", "--registered", "Modules registered in the application") { |options[:registered]| }
      opts.on("-v", "--version", "Show the #{File.basename($0)} version number and quit.")
    end

    def extract_options
      # for each option, extract it into a local variable (and create an "attr_reader :author" at the top)
      # Templates can access these value via the attr_reader-generated methods, but not the
      # raw instance variable value.
      # @author = options[:author]
      @description = options[:desc] || "Description of your project"
      @version = options[:version] || "0.1"
      @modules = options[:modules] || "#{@name}_app"
      @registered = options[:registered] || ""
    end
end