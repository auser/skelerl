# You also need to setup your name and email for git if you haven't already done so.
# Info at http://github.com/guides/tell-git-your-user-name-and-email-address

begin
class Array
  def one_of_regex
    option_list = join "|"
    Regexp.new "(#{option_list})"
  end
end
  require 'rubygems'
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "skelerl"
    s.description = "Erlang skeleton application"
    s.summary = <<-EOM      
      The most awesomenest erlang skeleton and generator!
    EOM
    
    s.homepage = "http://poolpartyrb.com"
    s.email = "arilerner@mac.com"
    s.authors = ["Ari Lerner", "Michael Fairchild", "Nate Murray"]
    
    s.test_files = Dir["test/**/test_*.rb"]

    s.files = (%w(Rakefile README.rdoc License.txt VERSION.yml) + Dir["{config,tasks,script,generators,lib,bin}/**/*"])
    
    s.files.exclude '**/*.beam'
    s.files.exclude "**/*/erl_crash.dump"
    
    s.has_rdoc = true
    s.extra_rdoc_files = ["README.txt", "License.txt", 'History.txt']
    s.rdoc_options = ['--quiet', '--title', 'Skelerl documentation',
        # "index.html",
        "--line-numbers",
        "--main", "README"
        ]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
