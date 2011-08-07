class AddResourceToOwnedResource < ActiveRecord::Migration
  def self.up
    add_column :owned_resources, :resource_type, :string, :null => false
    add_column :owned_resources, :resource_id, :integer, :null => false
  end

  def self.down
    remove_column :owned_resources, :resource_id
    remove_column :owned_resources, :resource_type
  end
end
