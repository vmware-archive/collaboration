class User < ActiveRecord::Base
  has_many :acls, :as => :entity
  has_many :projects, :through => :acls
  has_many :orgs, :through => :projects
  has_many :group_members, :dependent => :destroy

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :display_name, :username

  validates_presence_of :display_name
end
