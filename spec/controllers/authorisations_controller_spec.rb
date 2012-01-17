require 'spec_helper'

describe AuthorisationsController do
  describe 'GET new' do
    let :client do
      OAuth2::Provider.client_class.create! name: 'Test Client'
    end

    let :user do
      User.create! name: 'Tom', email: 'tom@popdog.net', password: 'Sufficiently complex passphrase!', uid: 'sommut'
    end

    let :valid_params do
      {
        client_id: client.oauth_identifier,
        client_secret: client.oauth_secret,
        grant_type: 'authorization_code',
        redirect_uri: 'http://test.com/oauth/callback'
      }
    end

    describe 'when user not logged in' do
      it 'redirects to login' do
        get :new
        response.should redirect_to(new_user_session_path)
      end
    end

    describe 'if no authorisation yet exists' do
      before :each do
        sign_in user
      end

      it 'presents new authorisation page to user' do
        get :new, valid_params
        response.status.should eql(200)
        response.should render_template('authorisations/new')
      end
    end

    describe 'if authorisation already exists' do
      before :each do
        sign_in user
        @authorisation = OAuth2::Provider.authorization_class.create!(client: client, resource_owner: user)
      end

      it 'responds with code linked to existing authorisation' do
        oauth2_response = catch :oauth2 do
          get :new, valid_params
        end
        code = OAuth2::Provider.authorization_code_class.last
        oauth2_response.should_not be_nil
        oauth2_response[0].should eql(302)
        oauth2_response[1]["Location"].should eql('http://test.com/oauth/callback?code=' + code.code)
        code.authorization.should eql(@authorisation)
      end
    end
  end
end
