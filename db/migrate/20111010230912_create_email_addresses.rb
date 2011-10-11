class CreateEmailAddresses < ActiveRecord::Migration
  def self.up
    create_table :email_addresses do |t|
      t.string :email, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end
    add_index :email_addresses, :user_id
    add_index :email_addresses, :email
  end

  def self.down
    remove_index :email_addresses, :user_id
    remove_index :email_addresses, :email
    drop_table :email_addresses
  end
end
