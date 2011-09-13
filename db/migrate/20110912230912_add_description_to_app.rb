class AddDescriptionToApp < ActiveRecord::Migration
  def self.up
    add_column :apps, :description, :string
    add_column :apps, :url, :string
  end

  def self.down
    remove_column :apps, :description
    remove_column :apps, :url
  end
end
