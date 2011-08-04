class CreateResourceAssignments < ActiveRecord::Migration
  def self.up
    create_table :resource_assignments do |t|
      t.integer :permission_set
      t.integer :project_id
      t.integer :entity_id
      t.string :entity_type
      t.integer :owned_resource_id

      t.timestamps
    end
  end

  def self.down
    drop_table :resource_assignments
  end
end
