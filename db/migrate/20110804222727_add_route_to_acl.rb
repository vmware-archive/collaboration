class AddRouteToAcl < ActiveRecord::Migration
  def self.up
    add_column :acls, :route, :text
  end

  def self.down
    remove_column :acls, :route
  end
end
