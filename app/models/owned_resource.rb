class OwnedResource < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  belongs_to :resource, :polymorphic => true
  has_many :acls, :dependent => :destroy

  validates_presence_of :resource, :owner

end
