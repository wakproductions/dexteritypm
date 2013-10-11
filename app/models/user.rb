class User < ActiveRecord::Base
  has_many :projects
  has_many :comments

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
end
