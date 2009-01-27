require "#{File.dirname(__FILE__)}/../helper"

class ObjectTest < Test::Unit::TestCase
  context "Object" do
    setup do
      @o = Object.new
    end
    
    context "for method erlang" do
      should "respond to :erlang" do
        assert_respond_to @o, :erlang
      end
      
      should "create a new ErlMapper" do
        blk = Proc.new {}
        assert_equal ErlMapper, @o.erlang(&blk).class
      end
      
      should "not create a new ErlMapper if there is no block passed" do
        assert_equal @o.erlang, nil
      end
    end    
    
  end
  
end