class UsersController < ApplicationController
  authenticate_with_oauth
  
  
  def show
    respond_to do |wants|
      wants.json { render :json => current_user.to_sensible_json }
    end
  end
end
