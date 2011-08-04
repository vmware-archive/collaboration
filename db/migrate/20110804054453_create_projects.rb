class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :display_name
      t.integer :organization_id
      t.boolean :apply_to_all_resources
      t.boolean :browsable
      t.boolean :public_roster

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
