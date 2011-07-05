class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  
  attr_accessible :uid, :name, :email, :password, :password_confirmation, :twitter, :github, :beard
  attr_readonly   :uid
  
  def to_sensible_json
    to_json(:only => [:uid, :version, :name, :email, :github, :twitter])
  end
end
