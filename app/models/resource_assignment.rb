class ResourceAssignment < ActiveRecord::Base
  belongs_to :project
  has_one :organization, :through => :project
  belongs_to :entity, :polymorphic => true
  has_one :owned_resource
  has_one :resource, :through => :owned_resource
end
