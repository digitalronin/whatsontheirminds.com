require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mp do

  before(:each) do
    @params = {
      :full_name => "John Expense-Fiddler",
      :person_id => 1234,
      :party => "Lying Bastards",
      :constituency => "Somewhere in the tory belt"
    }
  end

  it "should update cloud if wrans is different" do
    mp = Mp.make
    mock_twfy_for_mp mp, "Here is the first text"
    mp.get_cloud
    mock_twfy_for_mp mp, "Here is some different text"
    mp.get_cloud
    Cloud.count.should == 2
  end

  it "should not update cloud if wrans is same" do
    Cloud.delete_all
    mp = Mp.make
    mock_twfy_for_mp mp, "Always the same"
    mp.get_cloud
    mp.reload
    mp.get_cloud
    Cloud.count.should == 1
  end

  it "should store written questions text" do
    mp = Mp.make
    mp.written_questions_text.should be_nil
    mock_twfy_for_mp mp
    mp.get_cloud
    stored = Mp.find mp.id
    stored.written_questions_text.should == 'wibble'
  end

  it "should store cloud" do
    Cloud.delete_all
    mp = Mp.make
    mock_twfy_for_mp mp
    mp.get_cloud
    Cloud.count.should == 1
  end

  it "should fetch cloud from twfy" do
    mp = Mp.make
    mock_twfy_for_mp mp
    mp.get_cloud
  end

  it "should require unique person_id" do
    mp = Mp.new @params
    mp.should be_valid

    Mp.make :person_id => 1234
    mp = Mp.new @params
    mp.should_not be_valid
    mp.should have(1).error_on(:person_id)
  end

  it "should require numeric person_id" do
    ['wibble', 123.45].each do |invalid|
      mp = Mp.new @params.merge(:person_id => invalid)
      mp.should_not be_valid
      mp.should have(1).error_on(:person_id)
    end
  end

  it "should require parameters" do
    [:full_name, :person_id].each do |missing|
      mp = Mp.new @params.except(missing)
      mp.should_not be_valid
      [mp.errors[missing]].flatten.size.should >= 1
    end
  end

  it "should save in the db, after fetching from twfy" do
    Mp.delete_all
    constituency = mock "Constituency", :name => "Someplace"
    twfy = mock "MP", @params.merge(:name => nil, :constituency => constituency)
    Mp.find_or_create_from_twfy twfy
    Mp.count.should == 1
  end

  it "should fetch list from twfy" do
    twfy = mock_model Twfy::Client
    Twfy::Client.stub!(:new).and_return twfy
    twfy.should_receive(:mps).and_return []

    Mp.fetch_list
  end

end

def mock_twfy_for_mp(mp, text = 'wibble')
  TagExtractor.stub!(:extract).and_return(sample_text_terms)
  twfy = mock_model Twfy::Client
  Twfy::Client.stub!(:new).and_return twfy
  dummy = mock "Answers", :rows => [{'body' => text}]
  twfy.stub!(:wrans).with(:person => mp.person_id).and_return(dummy)
end

