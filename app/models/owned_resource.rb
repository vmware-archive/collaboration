class OwnedResource < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  belongs_to :resource, :polymorphic => true
end
