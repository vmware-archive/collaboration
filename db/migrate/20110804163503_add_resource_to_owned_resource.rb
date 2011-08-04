class AddResourceToOwnedResource < ActiveRecord::Migration
  def self.up
    add_column :owned_resources, :resource_type, :string
    add_column :owned_resources, :resource_id, :integer
  end

  def self.down
    remove_column :owned_resources, :resource_id
    remove_column :owned_resources, :resource_type
  end
end
