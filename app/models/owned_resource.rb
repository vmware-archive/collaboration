class OwnedResource < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  belongs_to :resource, :polymorphic => true
  has_many :acls, :dependent => :delete_all

  validates_presence_of :resource, :owner

  def to_s
    return "#{resource_type} - #{resource.display_name}" if resource
    base.to_s
  end

end
