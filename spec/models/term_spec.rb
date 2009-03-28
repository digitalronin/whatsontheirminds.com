require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Term do

  it "should have same coordinates for different values" do
    foo = Term.new :text => 'foo', :value => 10
    bar = Term.new :text => 'foo', :value => 5
    foo.x.should == bar.x
    foo.y.should == bar.y
  end

  it "should have different coordinates for different terms" do
    foo = Term.new :text => 'foo', :value => 10
    bar = Term.new :text => 'bar', :value => 10
    foo.x.should_not == bar.x
    foo.y.should_not == bar.y
  end

  it "should have same coordinates for same terms" do
    foo = Term.new :text => 'foo', :value => 10
    bar = Term.new :text => 'foo', :value => 10
    foo.x.should == bar.x
    foo.y.should == bar.y
  end

  it "should have coordinates" do
    foo = Term.new :text => 'foo', :value => 10
    foo.x.should == 482
    foo.y.should == 227
  end
  
end

