class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  
  attr_accessible :name, :email, :password, :password_confirmation, :twitter, :github, :beard
  
  def to_sensible_json
    to_json(:only => [:name, :email, :github, :twitter])
  end
end
