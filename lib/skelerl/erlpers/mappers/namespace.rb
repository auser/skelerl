class Namespace < MappingContext
  def namespace_string
    @__name ? @__name : parent_string
  end
  def start_commands
    commands.map {|c| "-s #{namespace_string}:#{c}"}
  end
end