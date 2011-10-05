class AddUrlIndexToApps < ActiveRecord::Migration
  def self.up
    add_index :apps, :url
  end

  def self.down
    remove_index :apps, :url
  end
end
