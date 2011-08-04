class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.string :display_name
      t.string :url
      t.boolean  "active",          :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
