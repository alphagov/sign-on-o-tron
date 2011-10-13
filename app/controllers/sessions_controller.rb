class SessionsController < ApplicationController
  def destroy
    env['warden'].logout
    redirect_to '/'
  end
end
