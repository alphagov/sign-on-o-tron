class UsersController < ApplicationController
  authenticate_with_oauth_and_devise :only => :show
  before_filter :authenticate_user!, :only => :edit

  def show
    respond_to do |wants|
      wants.json { render :json => current_user.to_sensible_json }
    end
  end

  def edit
  end

  def update
    password_params = params.symbolize_keys.keep_if { |k, v| [:password, :password_confirmation].include?(k) }
    if current_user.update_attributes(password_params) 
      redirect_to root_path
    else
      render :edit
    end
  end
end
