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

protected
  def owned_resource_in_same_org
    errors[:acl] << "Resource must be in the same org" if (@org == owned_resource.owner)
  end

end
