class CreateApps < ActiveRecord::Migration
  def self.up
    create_table :apps do |t|
      t.string :display_name
      t.string :framework
      t.string :runtime
      t.string :state, :default => "STOPPED"

      t.timestamps
    end
  end

  def self.down
    drop_table :apps
  end
end
