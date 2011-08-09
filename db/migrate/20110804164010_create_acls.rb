class CreateAcls < ActiveRecord::Migration
  def self.up
    create_table :acls do |t|
      t.integer :permission_set, :default => 0
      t.integer :project_id
      t.integer :entity_id
      t.string :entity_type
      t.integer :owned_resource_id

      t.timestamps
    end
  end

  def self.down
    drop_table :acls
  end
end
