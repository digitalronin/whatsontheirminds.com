require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Cloud do

  before(:each) do
    Term.delete_all
    Cloud.delete_all
    @mp = mock_model Mp, :id => 99, :full_name => "Expense-fiddling Git"
    @mp.stub!(:text_for_cloud).and_return(sample_text)
    TagExtractor.stub!(:extract).and_return(sample_text_terms)
  end

  it "should save terms" do
    cloud = Cloud.new :mp => @mp
    cloud.save!
    Term.count.should == sample_text_terms.size
  end

  it "should save" do
    cloud = Cloud.new :mp => @mp
    cloud.save!
    Cloud.count.should == 1
  end

end

