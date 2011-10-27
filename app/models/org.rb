class Org < ActiveRecord::Base
  has_many :projects, :dependent => :destroy
  has_many :groups, :dependent => :destroy
  has_many :owned_resources, :dependent => :destroy, :as => :owner
  has_many :apps, :through => :owned_resources

  validates_presence_of :display_name
  attr_accessor :creator
  validates_presence_of :creator, :on => :create

  before_create do
    @admins = groups.build :display_name => 'Admins'
    @devs = groups.build :display_name => 'Developers'
    @default_project = projects.build :display_name => 'Default', :is_default => true

  end

  after_create do
    @admins.group_members.build :user => @creator
    @admins.save!
    @default_project.add_admin_role @admins
    @default_project.add_dev_role @devs
    @default_project.save!
  end

public
  def to_s
    display_name
  end
  def default_project
    projects.find_by_display_name "Default"
  end

  def can_user(perm_to_check, path, user)
    if default_project
      default_project.can_user(perm_to_check, path, user)
    else
      false
    end
  end

  # Another options is to loop through all the projects
  # org.projects.each do |project|
  #  return true if project.can_user perms, path, current_user
  #end

end
