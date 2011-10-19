class User < ActiveRecord::Base
  has_many :email_addresses, :dependent => :destroy
  has_many :acls, :as => :entity
  has_many :projects, :through => :acls

  has_many :group_members, :dependent => :destroy
  has_many :groups, :through => :group_members

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  def emails
    email_addresses.collect(&:email).join(', ')
  end

  def emails=value
    if (value != self.emails)
      email_addys = value.split(',')
      email_addys.each do |email|
        email = email.strip
        unless emails.include? email
          email_addresses.build :email => email
          # TODO not validated
        end
      end
    end
  end

  # Setup accessible (or protected) attributes for your model
  attr_accessible :emails, :avatar, :remote_avatar_url, :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :display_name, :username, :personal_org, :orgs_with_access

  attr_readonly :personal_org

  validates_presence_of :display_name

  mount_uploader :avatar, AvatarUploader

  before_create do
    self.email_addresses.build :email => email
  end

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
            user.password = Devise.friendly_token[0,20]
            user.password_confirmation = user.password
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

  def external_identities
    identities = UserAccessToken.get_tokens(self).collect &:provider
    identities.uniq
  end

  def self.get_user_from_auth(email, signed_in_resource=nil)
    if addy = EmailAddress.find_by_email(email)
      addy.user
    elsif user = User.find_by_email(email)
      logger.debug "Cleaning user record #{email}"
      user.email_addresses.build :email => email
      user.save!
      return user
    elsif (signed_in_resource.nil?)
      User.create(:email => email, :password => Devise.friendly_token[0,20])
    else
      signed_in_resource.email_addresses.build :email => email
      signed_in_resource.save!
      signed_in_resource
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
