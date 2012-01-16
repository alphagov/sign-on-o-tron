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

  describe "password validation" do
    it "requires a password to be at least 10 characters long" do
      nine_character_string = 'i am9cha^'
      u = User.new(password: nine_character_string)
      u.should_not be_valid
      u.errors[:password].should_not be_empty
    end

    it "allows passwords of 128 characters with spaces in" do
      long_string = "AM a r3gul4t!0^ pa$$w0r()" * 5
      u = User.new(password: long_string)
      u.valid?
      u.errors[:password].should be_empty
    end

    it "rejects passwords that are purely alphanumeric" do
      alphanumeric_string = 'abcde12345fg'
      u = User.new(password: alphanumeric_string)
      u.should_not be_valid
      u.errors[:password].should_not be_empty
      u.errors.full_messages.should include('Password must contain at least two symbols other than numbers and letters')
    end
  end
end
