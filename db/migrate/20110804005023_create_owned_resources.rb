class CreateOwnedResources < ActiveRecord::Migration
  def self.up
    create_table :owned_resources do |t|
      t.boolean  :marked_for_transfer, :default => false
      t.boolean :deleted, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :owned_resources
  end
end
