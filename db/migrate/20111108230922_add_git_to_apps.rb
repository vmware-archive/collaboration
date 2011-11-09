class AddGitToApps < ActiveRecord::Migration
  def self.up
    add_column :apps, :browseable, :boolean
    add_column :apps, :cloneable, :boolean
    add_column :apps, :git_repo, :string
    add_column :apps, :avatar, :string
  end

  def self.down
    remove_column :apps, :browseable
    remove_column :apps, :cloneable
    remove_column :apps, :git_repo
    remove_column :apps, :avatar
  end
end
