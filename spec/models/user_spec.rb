require 'spec_helper'

describe User do
  describe "JSON serialisation" do
    before(:each) do
      @user = User.new(:name => 'Matt', :email => 'matt@alphagov.co.uk', :github => 'fidothe', :twitter => 'fidothe', :uid => 'abcde', :version => 1)
    end

    it "serialises a sensible set of attributes to JSON" do
      JSON.parse(@user.to_sensible_json).should == {'user' => {'name' => 'Matt', 'email' => 'matt@alphagov.co.uk', 'github' => 'fidothe', 'twitter' => 'fidothe', 'uid' => 'abcde', 'version' => 1}}
    end

    describe "generating gravatar URLs" do
      it "generates a valid default-sized URL" do
        @user.gravatar_url.should == "http://www.gravatar.com/avatar/7576330ca22fa087275c3ba1677ec1d5"
      end

      it "can generate a URL for a different-sized gravatar" do
        @user.gravatar_url(:s => 128).should == "http://www.gravatar.com/avatar/7576330ca22fa087275c3ba1677ec1d5?s=128"
      end

      it "can generate secure gravatar URLs if needed" do
        @user.gravatar_url(:ssl => true).should == "https://secure.gravatar.com/avatar/7576330ca22fa087275c3ba1677ec1d5"
      end
    end
  end
end
