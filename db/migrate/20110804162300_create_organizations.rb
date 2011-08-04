class CreateOrganizations < ActiveRecord::Migration
  def self.up
    create_table :organizations do |t|
      t.string :display_name
      t.string :avatar
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :organizations
  end
end
