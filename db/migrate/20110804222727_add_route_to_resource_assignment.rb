class AddRouteToResourceAssignment < ActiveRecord::Migration
  def self.up
    add_column :resource_assignments, :route, :text
  end

  def self.down
    remove_column :resource_assignments, :route
  end
end
