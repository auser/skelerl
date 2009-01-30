require "#{File.dirname(__FILE__)}/../helper"

class ErlMapperTest < Test::Unit::TestCase
  context "ErlMapper" do    
    context "methods" do
      
      context "options" do
        
        setup do;@mapper = ErlMapper.new do;a "a";b = nil;end;end
        describe "passed in with a hash" do
          it "should set the option on the ErlMapper" do;@mapper.a.should == "a";end
          it "should not set the option when passed a nil value" do;@mapper.b.should == nil;end
        end
        describe "passed in on the block" do          
          it "should set the option on the ErlMapper" do;@mapper.a.should == "a";end
          it "should not set the option when passed a nil value" do;@mapper.b.should == nil;end
        end
      end
      
      context "with_node" do
        setup do;@mapper = ErlMapper.new do;with_node(:node0) do; "hi";end;end;end
        describe "on call" do
          it "should create a MappingContext" do
            assert_equal @mapper.with_node(:node0).class, MappingContext
          end
          it "should store the MappingContext's name" do
            assert_equal @mapper.with_node(:node0).sname, :node0
          end
          it "should append the name to the MappingContext's string" do
            assert_equal "erl -sname node0 -pa ./ebin ", @mapper.with_node(:node0).build_string
          end
          
          context "context" do
            setup do;@context = @mapper.with_node(:node0) do;start;end;end
            
            describe "with start_commands" do            
              it "should have the start_commands on the MappingContext" do              
                assert_equal @context.commands, ["start"]
              end
              it "should have multiple when multiple are called" do
                @context.instance_eval do
                  chordjerl_srv:start
                end
                assert_equal @context.commands, ["start", "chordjerl_srv start"]
              end
            end
            
            describe "with final_commands" do
              it "should have the default final_commands as -s init stop" do
                assert_equal @context.final_commands, "-s init stop"
              end
              it "should not have the final_commands with stop if stop is false" do
                cont = MappingContext.new :node1, {:stop => false} do                  
                end
                assert_equal cont.final_commands, ""
              end
              it "with stop if stop is true" do
                cont = MappingContext.new :node2, {:stop => true} do                  
                end
                assert_equal cont.final_commands, "-s init stop"
              end
            end
            
          end
          
        end
      end
    end
    
    context "Namespace" do
      setup do
        @namespace = Namespace.new("chordjerl_srv") do
          start
        end
      end
      it "should keep the namespace on the command" do
        assert_equal "erl  -s chordjerl_srv:start", @namespace.string
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