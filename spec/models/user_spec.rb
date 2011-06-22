require 'spec_helper'

describe User do
  describe "JSON serialisation" do
    before(:each) do
      @user = User.new(:name => 'Matt', :email => 'matt@alphagov.co.uk', :github => 'fidothe', :twitter => 'fidothe')
    end
    
    it "serialises a sensible set of attributes to JSON" do
      JSON.parse(@user.to_sensible_json).should == {'user' => {'name' => 'Matt', 'email' => 'matt@alphagov.co.uk', 'github' => 'fidothe', 'twitter' => 'fidothe'}}
    end
  end
end
