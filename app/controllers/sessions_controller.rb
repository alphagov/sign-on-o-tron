class SessionsController < ApplicationController
  def destroy
    env['warden'].logout
    reset_session
    puts cookies.inspect
    redirect_to '/'
  end
end
