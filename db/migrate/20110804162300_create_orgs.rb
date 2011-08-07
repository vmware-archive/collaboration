class CreateOrgs < ActiveRecord::Migration
  def self.up
    create_table :orgs do |t|
      t.string :display_name, :null => false
      t.string :avatar
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :orgs
  end
end
