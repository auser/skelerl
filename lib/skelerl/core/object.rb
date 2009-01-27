class Object
  # The hidden singleton lurks behind everyone
  def metaclass; class << self; self; end; end
  def meta_eval &blk; metaclass.instance_eval &blk; end

  # Adds methods to a metaclass
  def meta_def name, &blk
    meta_eval { define_method name, &blk }
  end
  
  def meta_undef name
    meta_eval { remove_method name }
  end

  # Defines an instance method within a class
  def class_def name, &blk
    class_eval { define_method name, &blk }
  end
  
  def run_in_context(context=self, &block)
    name="temp_#{self.class}_#{respond_to?(:parent) ? parent.to_s : Time.now.to_i}".to_sym
    meta_def name, &block
    self.send name, context
    # self.instance_eval &block if block
    meta_undef name rescue ""
  end
end