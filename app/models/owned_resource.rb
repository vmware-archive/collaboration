class OwnedResource < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  belongs_to :resource, :polymorphic => true
  has_many :acls, :dependent => :delete_all

  validates_presence_of :resource, :owner

  def to_s
    resource.display_name if resource
  end

end
