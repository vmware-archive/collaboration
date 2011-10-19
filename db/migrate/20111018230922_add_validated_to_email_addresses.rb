class AddValidatedToEmailAddresses < ActiveRecord::Migration
  def self.up
    add_column :email_addresses, :validated, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :email_addresses, :validated
  end
end
