class AddVersionToServices < ActiveRecord::Migration
  def self.up
    add_column :services, :version, :string
    add_column :services, :type, :string
    add_column :services, :vendor, :string
  end

  def self.down
    remove_column :services, :version
    remove_column :services, :type
    remove_column :services, :vendor
  end
end
