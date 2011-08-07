class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :display_name, :null => false
      t.integer :organization_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
