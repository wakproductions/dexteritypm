class User < ActiveRecord::Base
  has_and_belongs_to_many :projects
  belongs_to :default_project, class_name: 'Project' # Note that we don't need to specify an association on the Project model
  has_many :comments

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
end
