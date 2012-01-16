class PasswordsController < Devise::PasswordsController
  def create
    self.resource = resource_class.send_reset_password_instructions(params[resource_name])
    flash.now[:alert] = "If that was a registered email address an email has been sent with instructions. If in doubt please consult someone!"
    render action: 'new'
  end
end