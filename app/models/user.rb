class User < ActiveRecord::Base
  has_many :acls, :as => :entity
  has_many :projects, :through => :acls

  has_many :group_members, :dependent => :destroy
  has_many :groups, :through => :group_members

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :avatar, :remote_avatar_url, :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :display_name, :username, :personal_org, :orgs_with_access

  attr_readonly :personal_org

  validates_presence_of :display_name

  mount_uploader :avatar, AvatarUploader

  after_create do
    Org.create! :creator => self, :display_name => "#{display_name}'s Personal Org", :personal => true
  end

  class << self
    def new_with_session(params, session)
      super.tap do |user|
        if session['devise.omniauth_info']
          if data = session['devise.omniauth_info']['user_info']
            user.display_name = data['name'] if data.has_key? 'name'
            user.email = data['email']
            user.username = data['nickname'] if data.has_key? 'nickname'
            user.first_name = data['first_name'] if data.has_key? 'first_name'
            user.last_name = data['last_name'] if data.has_key? 'last_name'
            user.remote_avatar_url = data['image'] if data.has_key? 'image'
          end
        end
      end
    end
  end

  def set_token_from_hash(hash)
    token = self.authorizations.find_or_initialize_by_provider(hash[:provider])
    token.update_attributes(
      :uid         => hash[:uid],
      :nickname    => hash[:nickname],
      :url         => hash[:url],
      :credentials => hash[:credentials]
    )
  end

public

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      user
    else # Create a user with a stub password.
      User.create(:email => data["email"], :password => Devise.friendly_token[0,20])
    end
  end

  def self.find_for_cloudfoundry_oauth(access_token, signed_in_resource=nil)
    data = access_token['user_info']
    if user = User.find_by_email(data["email"])
      user
    else # Create a user with a stub password.
      User.create(:email => data["email"], :password => Devise.friendly_token[0,20])
    end
  end

  def orgs_with_access
    orgs = []
    groups.each do |group|
      group.projects.each do |project|
        orgs << project.org
      end
    end
    projects.each do |project|
      orgs << project.org
    end
    orgs.uniq
  end

  def personal_org
    groups.each do |group|
      if group.display_name == 'Admins'
        if group.org.personal?
          return group.org
        end
      end
    end
    return nil
  end

end
