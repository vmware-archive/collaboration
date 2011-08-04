class CreateOwnedResources < ActiveRecord::Migration
  def self.up
    create_table :owned_resources do |t|
      t.string :display_name
      t.boolean :marked_for_transfer
      t.boolean :deleted

      t.timestamps
    end
  end

  def self.down
    drop_table :owned_resources
  end
end
