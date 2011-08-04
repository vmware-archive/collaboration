class AddOwnerToOwnedResource < ActiveRecord::Migration
  def self.up
    add_column :owned_resources, :owner_type, :string
    add_column :owned_resources, :owner_id, :integer
  end

  def self.down
    remove_column :owned_resources, :owner_id
    remove_column :owned_resources, :owner_type
  end
end
