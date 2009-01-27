%w(core erlpers).each do |dir|
  Dir["#{File.dirname(__FILE__)}/#{dir}/*.rb"].each {|f| require f if ::File.file? f}
end