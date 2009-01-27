require "#{File.dirname(__FILE__)}/../helper"

class ErlMapperTest < Test::Unit::TestCase
  context "ErlMapper" do    
    context "methods" do
      
      context "options" do
        
        describe "passed in with a hash" do
          setup do
            @mapper = ErlMapper.new do
              options :a => "a", :b => nil
            end
          end
          it "should set the option on the ErlMapper" do;@mapper.a.should == "a";end
          it "should not set the option when passed a nil value" do;@mapper.b.should == nil;end
        end
        describe "passed in on the block" do
          setup do
            @mapper = ErlMapper.new do
              a "a"
              b = nil
            end
          end
          
          it "should set the option on the ErlMapper" do;@mapper.a.should == "a";end
          it "should not set the option when passed a nil value" do;@mapper.b.should == nil;end
        end
      end
      
    end
    
    describe "Called from an object" do
      setup do
        @o = Object.new
      end
      
      it "should not fail" do
        blk = Proc.new {}
        lambda {@o.erlang(&blk)}.should_not raise_error
      end
      
    end    
    
  end
  
end