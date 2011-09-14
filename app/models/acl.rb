require 'permission_manager'
class Acl < ActiveRecord::Base
  include PermissionManager

  attr_accessor :create_bit, :read_bit, :update_bit, :delete_bit

  belongs_to :project
  has_one :org, :through => :project
  belongs_to :entity, :polymorphic => true
  belongs_to :owned_resource

  validates_presence_of :project, :entity

  validate :owned_resource_in_same_org, :if => :owned_resource

  def create_bit
    self.create?
  end

  def create_bit=(val)
    create! val
  end

  def read_bit
    self.read?
  end

  def read_bit=(val)
    read! val
  end

  def update_bit
    self.update?
  end

  def update_bit=(val)
    update! val
  end

  def delete_bit
    self.delete?
  end

  def delete_bit=(val)
    delete! val
  end

  def owned_resource_in_same_org
    errors[:acl] <<  "Resource must be in the same org" unless (project.org == owned_resource.owner)
  end

end
