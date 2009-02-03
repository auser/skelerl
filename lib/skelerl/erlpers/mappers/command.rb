class Command < Array
  def initialize(name=nil, *args)
    self << name.to_s
    self << args unless args.empty?
  end
  def method_missing(m, *args, &block)
    m = m.to_s
    self << (args.empty? ? [m] : [m, args]).flatten
  end
  def to_s
    self.flatten.join(" ")
  end
end